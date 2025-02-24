#define EXT_BOUND	1
#define INT_BOUND	2
#define NO_BOUND	3

#define SIPHONING	0
#define RELEASING	1

/obj/machinery/atmospherics/components/unary/vent_pump
	icon_state = "vent_map-3"

	name = "air vent"
	desc = "Has a valve and pump attached to it."

	use_power = IDLE_POWER_USE
	can_unwrench = TRUE
	welded = FALSE
	level = 1
	layer = GAS_SCRUBBER_LAYER
	shift_underlay_only = FALSE
	showpipe = FALSE

	var/id_tag = null
	var/pump_direction = RELEASING

	var/pressure_checks = EXT_BOUND
	var/external_pressure_bound = ONE_ATMOSPHERE
	var/internal_pressure_bound = 0
	// EXT_BOUND: Do not pass external_pressure_bound
	// INT_BOUND: Do not pass internal_pressure_bound
	// NO_BOUND: Do not pass either

	var/fast_fill = TRUE
	var/space_detection = TRUE
	var/space_shutoff_ticks = 0
	var/last_moles
	var/last_moles_added

	var/frequency = FREQ_ATMOS_CONTROL
	var/datum/radio_frequency/radio_connection
	var/radio_filter_out
	var/radio_filter_in

	var/obj/machinery/advanced_airlock_controller/aac = null

	pipe_state = "uvent"

/obj/machinery/atmospherics/components/unary/vent_pump/New()
	..()
	if(!id_tag)
		id_tag = assign_uid_vents()
	var/datum/gas_mixture/N = airs[1]
	N.set_volume(1000) // Increase the volume of the air vent's node.
	// Allows it to pump much faster.

/obj/machinery/atmospherics/components/unary/vent_pump/Destroy()
	var/area/A = get_area(src)
	if (A)
		A.air_vent_names -= id_tag
		A.air_vent_info -= id_tag
	if(aac)
		aac.vents -= src

	SSradio.remove_object(src,frequency)
	radio_connection = null
	return ..()

/obj/machinery/atmospherics/components/unary/vent_pump/update_icon_nopipes()
	cut_overlays()
	if(showpipe)
		var/image/cap = getpipeimage(icon, "vent_cap", initialize_directions)
		add_overlay(cap)
	else
		PIPING_LAYER_SHIFT(src, PIPING_LAYER_DEFAULT)

	if(welded)
		icon_state = "vent_welded"
		return

	if(!nodes[1] || !on || !is_operational())
		if(icon_state == "vent_welded")
			icon_state = "vent_off"
			return

		if(pump_direction & RELEASING)
			var/do_flick = (icon_state == "vent_out")
			if(space_shutoff_ticks > 0)
				icon_state = "vent_off_spaceerror"
			else
				icon_state = "vent_off"
			if(do_flick)
				flick("vent_out-off", src)
		else // pump_direction == SIPHONING
			var/do_flick = (icon_state == "vent_in")
			icon_state = "vent_off"
			if(do_flick)
				flick("vent_in-off",src)
		return

	if(icon_state == "vent_out-off" || icon_state == "vent_in-off" || icon_state == "vent_off" || icon_state == "vent_off_spaceerror")
		if(pump_direction & RELEASING)
			icon_state = "vent_out"
			flick("vent_out-starting", src)
		else // pump_direction == SIPHONING
			icon_state = "vent_in"
			flick("vent_in-starting", src)
		return

	if(pump_direction & RELEASING)
		icon_state = "vent_out"
	else // pump_direction == SIPHONING
		icon_state = "vent_in"

/obj/machinery/atmospherics/components/unary/vent_pump/process_atmos()
	..()
	if(!is_operational())
		last_moles_added = 0
		return
	if(space_shutoff_ticks > 0)
		space_shutoff_ticks--
		if(space_shutoff_ticks <= 1 && !on)
			on = TRUE
			update_icon()
	if(!nodes[1])
		on = FALSE
	if(!on || welded)
		last_moles_added = 0
		return

	var/datum/gas_mixture/air_contents = airs[1]
	var/datum/gas_mixture/environment = loc.return_air()
	var/environment_pressure = environment.return_pressure()
	var/environment_moles = environment.total_moles()
	var/last_moles_real_added = environment_moles - last_moles
	if(!aac)
		if((last_moles_added > 0 && environment_moles == 0 && space_detection) || (is_mining_level(z) && ISINRANGE(environment_moles, 36, 38)))
			// looks like we have a S P A C E problem.
			last_moles_added = 0
			on = FALSE
			space_shutoff_ticks = 20 // shut off for about 20 seconds before trying again.
			update_icon()
			return

	if(pump_direction & RELEASING) // internal -> external
		var/pressure_delta = 10000

		if(pressure_checks&EXT_BOUND)
			var/multiplier = 1 // fast_fill multiplier
			if(fast_fill)
				if(last_moles_added > 0 && last_moles_real_added > 0)
					multiplier = clamp(last_moles_added / last_moles_real_added * 0.25, 1, 100)
				else if(last_moles_added > 0 && last_moles_real_added < 0 && environment_moles != 0)
					multiplier = 10 // pressure is going down, but let's fight it anyways
			pressure_delta = min(pressure_delta, (external_pressure_bound - environment_pressure) * multiplier)
		if(pressure_checks&INT_BOUND)
			pressure_delta = min(pressure_delta, (air_contents.return_pressure() - internal_pressure_bound))
		if(space_shutoff_ticks > 0) // if we just came off a space-shutoff, only transfer a little bit.
			pressure_delta = min(pressure_delta, 10)

		if(pressure_delta > 0)
			if(air_contents.return_temperature() > 0)

				var/transfer_moles = pressure_delta*environment.return_volume()/(air_contents.return_temperature() * R_IDEAL_GAS_EQUATION)
				last_moles_added = transfer_moles

				var/datum/gas_mixture/removed = air_contents.remove(transfer_moles)

				loc.assume_air(removed)
				air_update_turf()

	else // external -> internal
		last_moles_added = 0
		if(environment.return_pressure() > 0)
			var/our_multiplier = air_contents.return_volume() / (environment.return_temperature() * R_IDEAL_GAS_EQUATION)
			var/moles_delta = 10000 * our_multiplier
			if(pressure_checks&EXT_BOUND)
				moles_delta = min(moles_delta, (environment_pressure - external_pressure_bound) * environment.return_volume() / (environment.return_temperature() * R_IDEAL_GAS_EQUATION))
			if(pressure_checks&INT_BOUND)
				moles_delta = min(moles_delta, (internal_pressure_bound - air_contents.return_pressure()) * our_multiplier)

			if(moles_delta > 0)
				var/datum/gas_mixture/removed = loc.remove_air(moles_delta)
				if (isnull(removed)) // in space
					return

				air_contents.merge(removed)
				air_update_turf()
	last_moles = environment_moles
	update_parents()

//Radio remote control

/obj/machinery/atmospherics/components/unary/vent_pump/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	if(frequency)
		radio_connection = SSradio.add_object(src, frequency,radio_filter_in)

/obj/machinery/atmospherics/components/unary/vent_pump/proc/broadcast_status()
	if(!radio_connection)
		return

	var/datum/signal/signal = new(list(
		"tag" = id_tag,
		"frequency" = frequency,
		"device" = "VP",
		"timestamp" = world.time,
		"power" = on,
		"direction" = pump_direction ? "release" : "siphon",
		"checks" = pressure_checks,
		"internal" = internal_pressure_bound,
		"external" = external_pressure_bound,
		"sigtype" = "status",
		"has_aac" = aac != null
	))

	var/area/A = get_area(src)
	if(!A.air_vent_names[id_tag])
		name = "\improper [A.name] vent pump #[A.air_vent_names.len + 1]"
		A.air_vent_names[id_tag] = name
	A.air_vent_info[id_tag] = signal.data

	radio_connection.post_signal(src, signal, radio_filter_out)


/obj/machinery/atmospherics/components/unary/vent_pump/atmosinit()
	//some vents work his own spesial way
	radio_filter_in = frequency==FREQ_ATMOS_CONTROL?(RADIO_FROM_AIRALARM):null
	radio_filter_out = frequency==FREQ_ATMOS_CONTROL?(RADIO_TO_AIRALARM):null
	if(frequency)
		set_frequency(frequency)
	broadcast_status()
	..()

/obj/machinery/atmospherics/components/unary/vent_pump/receive_signal(datum/signal/signal)
	if(!is_operational())
		return
	// log_admin("DEBUG \[[world.timeofday]\]: /obj/machinery/atmospherics/components/unary/vent_pump/receive_signal([signal.debug_print()])")
	if(!signal.data["tag"] || (signal.data["tag"] != id_tag) || (signal.data["sigtype"]!="command"))
		return

	var/atom/signal_sender = signal.data["user"]

	if("purge" in signal.data)
		pressure_checks &= ~EXT_BOUND
		pump_direction = SIPHONING

	if("stabilize" in signal.data)
		pressure_checks |= EXT_BOUND
		pump_direction = RELEASING

	if("power" in signal.data)
		on = text2num(signal.data["power"])
		space_shutoff_ticks = 0

	if("power_toggle" in signal.data)
		on = !on
		space_shutoff_ticks = 0

	if("checks" in signal.data)
		var/old_checks = pressure_checks
		pressure_checks = text2num(signal.data["checks"])
		if(pressure_checks != old_checks)
			investigate_log(" pressure checks were set to [pressure_checks] by [key_name(signal_sender)]",INVESTIGATE_ATMOS)

	if("checks_toggle" in signal.data)
		pressure_checks = (pressure_checks?0:NO_BOUND)

	if("direction" in signal.data)
		pump_direction = text2num(signal.data["direction"])

	if("set_internal_pressure" in signal.data)
		var/old_pressure = internal_pressure_bound
		internal_pressure_bound = clamp(text2num(signal.data["set_internal_pressure"]),0,ONE_ATMOSPHERE*50)
		if(old_pressure != internal_pressure_bound)
			investigate_log(" internal pressure was set to [internal_pressure_bound] by [key_name(signal_sender)]",INVESTIGATE_ATMOS)

	if("set_external_pressure" in signal.data)
		var/old_pressure = external_pressure_bound
		external_pressure_bound = clamp(text2num(signal.data["set_external_pressure"]),0,ONE_ATMOSPHERE*50)
		if(old_pressure != external_pressure_bound)
			investigate_log(" external pressure was set to [external_pressure_bound] by [key_name(signal_sender)]",INVESTIGATE_ATMOS)

	if("reset_external_pressure" in signal.data)
		external_pressure_bound = ONE_ATMOSPHERE

	if("reset_internal_pressure" in signal.data)
		internal_pressure_bound = 0

	if("adjust_internal_pressure" in signal.data)
		internal_pressure_bound = clamp(internal_pressure_bound + text2num(signal.data["adjust_internal_pressure"]),0,ONE_ATMOSPHERE*50)

	if("adjust_external_pressure" in signal.data)
		external_pressure_bound = clamp(external_pressure_bound + text2num(signal.data["adjust_external_pressure"]),0,ONE_ATMOSPHERE*50)

	if("init" in signal.data)
		name = signal.data["init"]
		return

	if("status" in signal.data)
		broadcast_status()
		return // do not update_icon

		// log_admin("DEBUG \[[world.timeofday]\]: vent_pump/receive_signal: unknown command \"[signal.data["command"]]\"\n[signal.debug_print()]")
	broadcast_status()
	update_icon()

/obj/machinery/atmospherics/components/unary/vent_pump/welder_act(mob/living/user, obj/item/I)
	if(!I.tool_start_check(user, amount=0))
		return TRUE
	to_chat(user, span_notice("You begin welding the vent..."))
	if(I.use_tool(src, user, 20, volume=50))
		if(!welded)
			user.visible_message("[user] welds the vent shut.", span_notice("You weld the vent shut."), span_italics("You hear welding."))
			welded = TRUE
		else
			user.visible_message("[user] unwelded the vent.", span_notice("You unweld the vent."), span_italics("You hear welding."))
			welded = FALSE
		update_icon()
		pipe_vision_img = image(src, loc, layer = ABOVE_HUD_LAYER, dir = dir)
		pipe_vision_img.plane = ABOVE_HUD_PLANE
		investigate_log("was [welded ? "welded shut" : "unwelded"] by [key_name(user)]", INVESTIGATE_ATMOS)
		add_fingerprint(user)
	return TRUE

/obj/machinery/atmospherics/components/unary/vent_pump/can_unwrench(mob/user)
	. = ..()
	if(. && on && is_operational())
		to_chat(user, span_warning("You cannot unwrench [src], turn it off first!"))
		return FALSE

/obj/machinery/atmospherics/components/unary/vent_pump/examine(mob/user)
	. = ..()
	if(welded)
		. += "It seems welded shut."

/obj/machinery/atmospherics/components/unary/vent_pump/power_change()
	. = ..()
	update_icon_nopipes()

/obj/machinery/atmospherics/components/unary/vent_pump/can_crawl_through()
	return !welded

/obj/machinery/atmospherics/components/unary/vent_pump/attack_alien(mob/user)
	if(!welded || !(do_after(user, 20, target = src)))
		return
	user.visible_message("[user] furiously claws at [src]!", "You manage to clear away the stuff blocking the vent", "You hear loud scraping noises.")
	welded = FALSE
	update_icon()
	pipe_vision_img = image(src, loc, layer = ABOVE_HUD_LAYER, dir = dir)
	pipe_vision_img.plane = ABOVE_HUD_PLANE
	playsound(loc, 'sound/weapons/bladeslice.ogg', 100, 1)

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume
	name = "large air vent"
	power_channel = EQUIP

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/New()
	..()
	var/datum/gas_mixture/air_contents = airs[1]
	air_contents.set_volume(1000)

// mapping

/obj/machinery/atmospherics/components/unary/vent_pump/layer2
	piping_layer = 2
	icon_state = "vent_map-2"

/obj/machinery/atmospherics/components/unary/vent_pump/layer4
	piping_layer = 4
	icon_state = "vent_map-4"

/obj/machinery/atmospherics/components/unary/vent_pump/on
	on = TRUE
	icon_state = "vent_map_on-3"

/obj/machinery/atmospherics/components/unary/vent_pump/on/layer2
	piping_layer = 2
	icon_state = "vent_map_on-2"
	showpipe = FALSE

/obj/machinery/atmospherics/components/unary/vent_pump/on/layer4
	piping_layer = 4
	icon_state = "vent_map_on-4"
	showpipe = FALSE

/obj/machinery/atmospherics/components/unary/vent_pump/siphon
	pump_direction = SIPHONING
	pressure_checks = INT_BOUND
	internal_pressure_bound = 4000
	external_pressure_bound = 0

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/layer2
	piping_layer = 2
	icon_state = "vent_map-2"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/layer4
	piping_layer = 4
	icon_state = "vent_map-4"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/on
	on = TRUE
	icon_state = "vent_map_siphon_on-3"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/on/layer2
	piping_layer = 2
	icon_state = "vent_map_siphon_on-2"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/on/layer4
	piping_layer = 4
	icon_state = "vent_map_siphon_on-4"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos
	frequency = FREQ_ATMOS_STORAGE
	on = TRUE
	icon_state = "vent_map_siphon_on-3"

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/toxin_output
	name = "plasma tank output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_TOX
/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/oxygen_output
	name = "oxygen tank output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_O2
/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/nitrogen_output
	name = "nitrogen tank output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_N2
/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/mix_output
	name = "mix tank output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_MIX
/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/nitrous_output
	name = "nitrous oxide tank output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_N2O
/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/carbon_output
	name = "carbon dioxide tank output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_CO2
/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/incinerator_output
	name = "incinerator chamber output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_INCINERATOR
	frequency = FREQ_ATMOS_CONTROL
/obj/machinery/atmospherics/components/unary/vent_pump/siphon/atmos/toxins_mixing_output
	name = "toxins mixing output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_TOXINS_LAB
	frequency = FREQ_ATMOS_CONTROL

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/layer2
	piping_layer = 2
	icon_state = "vent_map-2"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/layer4
	piping_layer = 4
	icon_state = "vent_map-4"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/on
	on = TRUE
	icon_state = "vent_map_on-3"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/on/layer2
	piping_layer = 2
	icon_state = "vent_map_on-2"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/on/layer4
	piping_layer = 4
	icon_state = "map_vent_on-4"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon
	pump_direction = SIPHONING
	pressure_checks = INT_BOUND
	internal_pressure_bound = 2000
	external_pressure_bound = 0

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/layer2
	piping_layer = 2
	icon_state = "vent_map-2"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/layer4
	piping_layer = 4
	icon_state = "map_vent-4"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/on
	on = TRUE
	icon_state = "vent_map_siphon_on-3"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/on/layer2
	piping_layer = 2
	icon_state = "vent_map_siphon_on-2"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/on/layer4
	piping_layer = 4
	icon_state = "vent_map_siphon_on-4"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos
	frequency = FREQ_ATMOS_STORAGE
	on = TRUE
	icon_state = "vent_map_siphon_on-3"

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/atmos/air_output
	name = "air mix tank output inlet"
	id_tag = ATMOS_GAS_MONITOR_OUTPUT_AIR

#undef INT_BOUND
#undef EXT_BOUND
#undef NO_BOUND

#undef SIPHONING
#undef RELEASING

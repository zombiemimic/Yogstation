/obj/item/computer_hardware/card_slot
	name = "identification card authentication module"	// \improper breaks the find_hardware_by_name proc
	desc = "A module allowing this computer to read or write data on ID cards. Necessary for some programs to run properly."
	power_usage = 10 //W
	icon_state = "card_mini"
	w_class = WEIGHT_CLASS_TINY
	device_type = MC_CARD

	var/obj/item/card/id/stored_card = null
	var/obj/item/card/id/stored_card2 = null

/obj/item/computer_hardware/card_slot/handle_atom_del(atom/A)
	if(A == stored_card)
		try_eject(1, null, TRUE)
	if(A == stored_card2)
		try_eject(2, null, TRUE)
	. = ..()

/obj/item/computer_hardware/card_slot/Destroy()
	try_eject()
	return ..()

/obj/item/computer_hardware/card_slot/GetAccess()
	if(stored_card && stored_card2) // Best of both worlds
		return (stored_card.GetAccess() | stored_card2.GetAccess())
	else if(stored_card)
		return stored_card.GetAccess()
	else if(stored_card2)
		return stored_card2.GetAccess()
	return ..()

/obj/item/computer_hardware/card_slot/GetID()
	if(stored_card)
		return stored_card
	else if(stored_card2)
		return stored_card2
	return ..()

/obj/item/computer_hardware/card_slot/on_install(obj/item/modular_computer/M, mob/living/user = null)
	M.add_verb(device_type)

/obj/item/computer_hardware/card_slot/on_remove(obj/item/modular_computer/M, mob/living/user = null)
	M.remove_verb(device_type)

/obj/item/computer_hardware/card_slot/try_insert(obj/item/I, mob/living/user = null)
	if(!holder)
		return FALSE

	if(!istype(I, /obj/item/card/id))
		return FALSE

	if(stored_card && stored_card2)
		to_chat(user, span_warning("You try to insert \the [I] into \the [src], but its slots are occupied."))
		return FALSE
	if(user)
		if(!user.transferItemToLoc(I, src))
			return FALSE
	else
		I.forceMove(src)

	if(!stored_card)
		stored_card = I
	else
		stored_card2 = I
	to_chat(user, span_notice("You insert \the [I] into \the [src]."))
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, 0)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.sec_hud_set_ID()

	return TRUE


/obj/item/computer_hardware/card_slot/try_eject(slot=0, mob/living/user = null, forced = 0)
	if(!stored_card && !stored_card2)
		to_chat(user, span_warning("There are no cards in \the [src]."))
		return FALSE

	var/ejected = 0
	if(stored_card && (!slot || slot == 1))
		if(user && Adjacent(user))
			user.put_in_hands(stored_card)
		else
			stored_card.forceMove(drop_location())
		stored_card = null
		ejected++

	if(stored_card2 && (!slot || slot == 2))
		if(user && Adjacent(user))
			user.put_in_hands(stored_card2)
		else
			stored_card2.forceMove(drop_location())
		stored_card2 = null
		ejected++

	if(ejected)
		if(holder)
			if(holder.active_program)
				holder.active_program.event_idremoved(0, slot)

			for(var/I in holder.idle_threads)
				var/datum/computer_file/program/P = I
				P.event_idremoved(1, slot)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.sec_hud_set_ID()
		to_chat(user, span_notice("You remove the card[ejected>1 ? "s" : ""] from \the [src]."))
		playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, 0)
		return TRUE
	return FALSE

/obj/item/computer_hardware/card_slot/attackby(obj/item/I, mob/living/user)
	if(..())
		return
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, span_notice("You press down on the manual eject button with \the [I]."))
		try_eject(0,user)
		return

/obj/item/computer_hardware/card_slot/examine(mob/user)
	. = ..()
	if(stored_card || stored_card2)
		. += "There appears to be something loaded in the card slots."

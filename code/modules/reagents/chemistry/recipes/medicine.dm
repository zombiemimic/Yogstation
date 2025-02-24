/datum/chemical_reaction/insulin
	name = "Insulin"
	id = /datum/reagent/medicine/insulin
	results = list(/datum/reagent/medicine/insulin = 2)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1, /datum/reagent/medicine/antitoxin = 1)

/datum/chemical_reaction/leporazine
	name = "Leporazine"
	id = /datum/reagent/medicine/leporazine
	results = list(/datum/reagent/medicine/leporazine = 2)
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/copper = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)

/datum/chemical_reaction/rezadone
	name = "Rezadone"
	id = /datum/reagent/medicine/rezadone
	results = list(/datum/reagent/medicine/rezadone = 3)
	required_reagents = list(/datum/reagent/toxin/carpotoxin = 1, /datum/reagent/cryptobiolin = 1, /datum/reagent/copper = 1)

/datum/chemical_reaction/spaceacillin
	name = "Spaceacillin"
	id = /datum/reagent/medicine/spaceacillin
	results = list(/datum/reagent/medicine/spaceacillin = 2)
	required_reagents = list(/datum/reagent/cryptobiolin = 1, /datum/reagent/medicine/epinephrine = 1)

/datum/chemical_reaction/inacusiate
	name = /datum/reagent/medicine/inacusiate
	id = /datum/reagent/medicine/inacusiate
	results = list(/datum/reagent/medicine/inacusiate = 2)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/carbon = 1, /datum/reagent/medicine/charcoal = 1)

/datum/chemical_reaction/synaptizine
	name = "Synaptizine"
	id = /datum/reagent/medicine/synaptizine
	results = list(/datum/reagent/medicine/synaptizine = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/lithium = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/charcoal
	name = "Charcoal"
	id = /datum/reagent/medicine/charcoal
	results = list(/datum/reagent/medicine/charcoal = 2)
	required_reagents = list(/datum/reagent/ash = 1, /datum/reagent/consumable/sodiumchloride = 1)
	mix_message = "The mixture yields a fine black powder."
	required_temp = 380

/datum/chemical_reaction/silver_sulfadiazine
	name = "Silver Sulfadiazine"
	id = /datum/reagent/medicine/silver_sulfadiazine
	results = list(/datum/reagent/medicine/silver_sulfadiazine = 5)
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/silver = 1, /datum/reagent/sulfur = 1, /datum/reagent/oxygen = 1, /datum/reagent/chlorine = 1)

/datum/chemical_reaction/salglu_solution
	name = "Saline-Glucose Solution"
	id = /datum/reagent/medicine/salglu_solution
	results = list(/datum/reagent/medicine/salglu_solution = 3)
	required_reagents = list(/datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/water = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/mine_salve
	name = "Miner's Salve"
	id = /datum/reagent/medicine/mine_salve
	results = list(/datum/reagent/medicine/mine_salve = 3)
	required_reagents = list(/datum/reagent/oil = 1, /datum/reagent/water = 1, /datum/reagent/iron = 1)

/datum/chemical_reaction/mine_salve2
	name = "Miner's Salve"
	id = /datum/reagent/medicine/mine_salve
	results = list(/datum/reagent/medicine/mine_salve = 15)
	required_reagents = list(/datum/reagent/toxin/plasma = 5, /datum/reagent/iron = 5, /datum/reagent/consumable/sugar = 1) // A sheet of plasma, a twinkie and a sheet of metal makes four of these

/datum/chemical_reaction/synthflesh
	name = "Synthflesh"
	id = /datum/reagent/medicine/synthflesh
	results = list(/datum/reagent/medicine/synthflesh = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/carbon = 1, /datum/reagent/medicine/styptic_powder = 1)

/datum/chemical_reaction/styptic_powder
	name = "Styptic Powder"
	id = /datum/reagent/medicine/styptic_powder
	results = list(/datum/reagent/medicine/styptic_powder = 4)
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/hydrogen = 1, /datum/reagent/oxygen = 1, /datum/reagent/toxin/acid = 1)
	mix_message = "The solution yields an astringent powder."

/datum/chemical_reaction/calomel
	name = "Calomel"
	id = /datum/reagent/medicine/calomel
	results = list(/datum/reagent/medicine/calomel = 2)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/chlorine = 1)
	required_temp = 374

/datum/chemical_reaction/potass_iodide
	name = "Potassium Iodide"
	id = /datum/reagent/medicine/potass_iodide
	results = list(/datum/reagent/medicine/potass_iodide = 2)
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/iodine = 1)

/datum/chemical_reaction/pen_acid
	name = "Pentetic Acid"
	id = /datum/reagent/medicine/pen_acid
	results = list(/datum/reagent/medicine/pen_acid = 6)
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/chlorine = 1, /datum/reagent/ammonia = 1, /datum/reagent/toxin/formaldehyde = 1, /datum/reagent/sodium = 1, /datum/reagent/toxin/cyanide = 1)

/datum/chemical_reaction/sal_acid
	name = "Salicyclic Acid"
	id = /datum/reagent/medicine/sal_acid
	results = list(/datum/reagent/medicine/sal_acid = 5)
	required_reagents = list(/datum/reagent/sodium = 1, /datum/reagent/phenol = 1, /datum/reagent/carbon = 1, /datum/reagent/oxygen = 1, /datum/reagent/toxin/acid = 1)

/datum/chemical_reaction/oxandrolone
	name = "Oxandrolone"
	id = /datum/reagent/medicine/oxandrolone
	results = list(/datum/reagent/medicine/oxandrolone = 6)
	required_reagents = list(/datum/reagent/carbon = 3, /datum/reagent/phenol = 1, /datum/reagent/hydrogen = 1, /datum/reagent/oxygen = 1)

/datum/chemical_reaction/salbutamol
	name = "Salbutamol"
	id = /datum/reagent/medicine/salbutamol
	results = list(/datum/reagent/medicine/salbutamol = 5)
	required_reagents = list(/datum/reagent/medicine/sal_acid = 1, /datum/reagent/lithium = 1, /datum/reagent/aluminium = 1, /datum/reagent/bromine = 1, /datum/reagent/ammonia = 1)

/datum/chemical_reaction/perfluorodecalin
	name = "Perfluorodecalin"
	id = /datum/reagent/medicine/perfluorodecalin
	results = list(/datum/reagent/medicine/perfluorodecalin = 3)
	required_reagents = list(/datum/reagent/hydrogen = 1, /datum/reagent/fluorine = 1, /datum/reagent/oil = 1)
	required_temp = 370
	mix_message = "The mixture rapidly turns into a dense pink liquid."

/datum/chemical_reaction/ephedrine
	name = "Ephedrine"
	id = /datum/reagent/medicine/ephedrine
	results = list(/datum/reagent/medicine/ephedrine = 4)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/oil = 1, /datum/reagent/hydrogen = 1, /datum/reagent/diethylamine = 1)
	mix_message = "The solution fizzes and gives off toxic fumes."

/datum/chemical_reaction/diphenhydramine
	name = "Diphenhydramine"
	id = /datum/reagent/medicine/diphenhydramine
	results = list(/datum/reagent/medicine/diphenhydramine = 4)
	required_reagents = list(/datum/reagent/oil = 1, /datum/reagent/carbon = 1, /datum/reagent/bromine = 1, /datum/reagent/diethylamine = 1, /datum/reagent/consumable/ethanol = 1)
	mix_message = "The mixture dries into a pale blue powder."

/datum/chemical_reaction/oculine
	name = "Oculine"
	id = /datum/reagent/medicine/oculine
	results = list(/datum/reagent/medicine/oculine = 3)
	required_reagents = list(/datum/reagent/medicine/charcoal = 1, /datum/reagent/carbon = 1, /datum/reagent/hydrogen = 1)
	mix_message = "The mixture sputters loudly and becomes a pale pink color."

/datum/chemical_reaction/atropine
	name = "Atropine"
	id = /datum/reagent/medicine/atropine
	results = list(/datum/reagent/medicine/atropine = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/acetone = 1, /datum/reagent/diethylamine = 1, /datum/reagent/phenol = 1, /datum/reagent/toxin/acid = 1)

/datum/chemical_reaction/epinephrine
	name = "Epinephrine"
	id = /datum/reagent/medicine/epinephrine
	results = list(/datum/reagent/medicine/epinephrine = 6)
	required_reagents = list(/datum/reagent/phenol = 1, /datum/reagent/acetone = 1, /datum/reagent/diethylamine = 1, /datum/reagent/oxygen = 1, /datum/reagent/chlorine = 1, /datum/reagent/hydrogen = 1)

/datum/chemical_reaction/strange_reagent
	name = "Strange Reagent"
	id = /datum/reagent/medicine/strange_reagent
	results = list(/datum/reagent/medicine/strange_reagent = 3)
	required_reagents = list(/datum/reagent/medicine/rezadone = 1, /datum/reagent/water/holywater = 1, /datum/reagent/toxin/mutagen = 1)

/datum/chemical_reaction/mannitol
	name = "Mannitol"
	id = /datum/reagent/medicine/mannitol
	results = list(/datum/reagent/medicine/mannitol = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/hydrogen = 1, /datum/reagent/water = 1)
	mix_message = "The solution slightly bubbles, becoming thicker."

/datum/chemical_reaction/neurine
	name = "Neurine"
	id = /datum/reagent/medicine/neurine
	results = list(/datum/reagent/medicine/neurine = 3)
	required_reagents = list(/datum/reagent/medicine/mannitol = 1, /datum/reagent/acetone = 1, /datum/reagent/oxygen = 1)

/datum/chemical_reaction/mutadone
	name = "Mutadone"
	id = /datum/reagent/medicine/mutadone
	results = list(/datum/reagent/medicine/mutadone = 3)
	required_reagents = list(/datum/reagent/toxin/mutagen = 1, /datum/reagent/acetone = 1, /datum/reagent/bromine = 1)

/datum/chemical_reaction/antihol
	name = /datum/reagent/medicine/antihol
	id = /datum/reagent/medicine/antihol
	results = list(/datum/reagent/medicine/antihol = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/medicine/charcoal = 1, /datum/reagent/copper = 1)

/datum/chemical_reaction/cryoxadone
	name = "Cryoxadone"
	id = /datum/reagent/medicine/cryoxadone
	results = list(/datum/reagent/medicine/cryoxadone = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/acetone = 1, /datum/reagent/toxin/mutagen = 1)

/datum/chemical_reaction/pyroxadone
	name = "Pyroxadone"
	id = /datum/reagent/medicine/pyroxadone
	results = list(/datum/reagent/medicine/pyroxadone = 2)
	required_reagents = list(/datum/reagent/medicine/cryoxadone = 1, /datum/reagent/toxin/slimejelly = 1)

/datum/chemical_reaction/pyroxadone2
	name = "Pyroxadone"
	id = /datum/reagent/medicine/pyroxadone
	results = list(/datum/reagent/medicine/pyroxadone = 2)
	required_reagents = list(/datum/reagent/medicine/cryoxadone = 1, /datum/reagent/medicine/omnizine = 1, /datum/reagent/phlogiston = 1)

/datum/chemical_reaction/clonexadone
	name = "Clonexadone"
	id = /datum/reagent/medicine/clonexadone
	results = list(/datum/reagent/medicine/clonexadone = 2)
	required_reagents = list(/datum/reagent/medicine/cryoxadone = 1, /datum/reagent/sodium = 1)
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)

/datum/chemical_reaction/haloperidol
	name = "Haloperidol"
	id = /datum/reagent/medicine/haloperidol
	results = list(/datum/reagent/medicine/haloperidol = 5)
	required_reagents = list(/datum/reagent/chlorine = 1, /datum/reagent/fluorine = 1, /datum/reagent/aluminium = 1, /datum/reagent/medicine/potass_iodide = 1, /datum/reagent/oil = 1)

/datum/chemical_reaction/bicaridine
	name = "Bicaridine"
	id = /datum/reagent/medicine/bicaridine
	results = list(/datum/reagent/medicine/bicaridine = 4)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/oxygen = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/lemoline = 1)

/datum/chemical_reaction/kelotane
	name = "Kelotane"
	id = /datum/reagent/medicine/kelotane
	results = list(/datum/reagent/medicine/kelotane = 3)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/silicon = 1, /datum/reagent/lemoline = 1)

/datum/chemical_reaction/antitoxin
	name = "Antitoxin"
	id = /datum/reagent/medicine/antitoxin
	results = list(/datum/reagent/medicine/antitoxin = 4)
	required_reagents = list(/datum/reagent/nitrogen = 1, /datum/reagent/silicon = 1, /datum/reagent/potassium = 1, /datum/reagent/lemoline = 1)

/datum/chemical_reaction/tricordrazine
	name = "Tricordrazine"
	id = /datum/reagent/medicine/tricordrazine
	results = list(/datum/reagent/medicine/tricordrazine = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/medicine/kelotane = 1, /datum/reagent/medicine/antitoxin = 1)

/datum/chemical_reaction/regen_jelly
	name = "Regenerative Jelly"
	id = /datum/reagent/medicine/regen_jelly
	results = list(/datum/reagent/medicine/regen_jelly = 2)
	required_reagents = list(/datum/reagent/medicine/tricordrazine = 1, /datum/reagent/toxin/slimejelly = 1)

/datum/chemical_reaction/corazone
	name = "Corazone"
	id = /datum/reagent/medicine/corazone
	results = list(/datum/reagent/medicine/corazone = 3)
	required_reagents = list(/datum/reagent/phenol = 2, /datum/reagent/lithium = 1)

/datum/chemical_reaction/morphine
	name = "Morphine"
	id = /datum/reagent/medicine/morphine
	results = list(/datum/reagent/medicine/morphine = 2)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/consumable/ethanol = 1, /datum/reagent/oxygen = 1)
	required_temp = 480

/datum/chemical_reaction/modafinil
	name = "Modafinil"
	id = /datum/reagent/medicine/modafinil
	results = list(/datum/reagent/medicine/modafinil = 5)
	required_reagents = list(/datum/reagent/diethylamine = 1, /datum/reagent/ammonia = 1, /datum/reagent/phenol = 1, /datum/reagent/acetone = 1, /datum/reagent/toxin/acid = 1)
	required_catalysts = list(/datum/reagent/bromine = 1) // as close to the real world synthesis as possible

/datum/chemical_reaction/psicodine
	name = "Psicodine"
	id = /datum/reagent/medicine/psicodine
	results = list(/datum/reagent/medicine/psicodine = 5)
	required_reagents = list( /datum/reagent/medicine/mannitol = 2, /datum/reagent/water = 2, /datum/reagent/impedrezene = 1)

/datum/chemical_reaction/burnmix // Chemistry recipe
	name = "BurnMix"
	required_temp = 700
	id = /datum/reagent/medicine/burnmix
	mix_message = "The solution boils, binding the remaining ingredients."
	results = list(/datum/reagent/medicine/burnmix = 2)
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/carbon = 1, /datum/reagent/iron = 1)

/datum/chemical_reaction/burnmix2 // Ghetto recipe
	name = "BurnMix"
	id = /datum/reagent/medicine/burnmix
	required_temp = 500
	mix_message = "The solution bubbles, binding the ingredients."
	results = list(/datum/reagent/medicine/burnmix = 3) // Fuel burns away to form BurnMix from Nutriment and ash
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/consumable/nutriment = 1, /datum/reagent/ash = 2) // Some welding fluid, any food and ash (burn some paper)

/datum/chemical_reaction/burnmix3 // Ghetto recipe 2; wasteful . Replaces nutriment with ethenol but most of the ethenol dissolves in the process
	name = "BurnMix"
	id = /datum/reagent/medicine/burnmix
	required_temp = 500
	mix_message = "The solution partially dissolves, binding the remaining ingredients."
	results = list(/datum/reagent/medicine/burnmix = 3) // fuel and most ethenol burns away to form BurnMix from remaining ethenol and ash
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/consumable/ethanol/beer = 3, /datum/reagent/ash = 2) // Take a booze bottle, drink some , add welding fuel and ash. Heat up with lighter

/datum/chemical_reaction/tribalordrazine // Mushroom stem + ash from an ash pile + cactus fruit + heat the bowl with a welder
	name = "Tribalordrazine"
	id = /datum/reagent/medicine/tribalordrazine
	required_temp = 420
	mix_message = "The mixture binds together from the heat, releasing a pleasant smelling smoke."
	results = list(/datum/reagent/medicine/tribalordrazine = 10) // Pretty intensive to get this, so this amount is fair. That and this chem isn't very good.
	required_reagents = list(/datum/reagent/ash = 5, /datum/reagent/consumable/vitfro = 2, /datum/reagent/consumable/tinlux = 1)

/datum/chemical_reaction/tribaldetox // Mushroom cap + ash from an ash pile + heat the bowl with a welder
	name = "Cap Mix"
	id = /datum/reagent/medicine/tribaldetox
	required_temp = 420
	mix_message = "The mixture binds together from the heat, releasing a disgusting smelling smoke."
	results = list(/datum/reagent/medicine/tribaldetox = 10)
	required_reagents = list(/datum/reagent/ash = 10, /datum/reagent/consumable/entpoly = 1)

///medical stacks

/datum/chemical_reaction/medsuture
	name = "Medicated Suture"
	id = "med_suture"
	required_reagents = list(/datum/reagent/cellulose = 10, /datum/reagent/toxin/formaldehyde = 20, /datum/reagent/medicine/polypyr = 15)

/datum/chemical_reaction/medsuture/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/stack/medical/suture/medicated(location)

/datum/chemical_reaction/medmesh
	name = "Advanced Mesh"
	id = "adv_mesh"
	required_reagents = list(/datum/reagent/cellulose = 20, /datum/reagent/consumable/aloejuice = 20, /datum/reagent/space_cleaner/sterilizine = 10)

/datum/chemical_reaction/medmesh/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= created_volume, i++)
		new /obj/item/stack/medical/mesh/advanced(location)

/datum/chemical_reaction/poultice
	name = "poultice"
	id = "poultice"
	required_reagents = list(/datum/reagent/toxin/amanitin = 10, /datum/reagent/cellulose = 20, /datum/reagent/consumable/aloejuice = 20)

/datum/chemical_reaction/poultice/alt
	name = "poultice"
	id = "poultice_alt"
	required_reagents = list(/datum/reagent/consumable/entpoly = 15, /datum/reagent/cellulose = 20, /datum/reagent/consumable/tinlux = 12)

/datum/chemical_reaction/poultice/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/stack/medical/poultice(location)

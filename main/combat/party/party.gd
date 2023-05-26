class_name Party
extends Node
# A collection of fighters on the same team within a battle

func get_active_fighters() -> Array[Fighter]:
	var active: Array[Fighter] = []
	for fighter in get_children():
		if fighter.active:
			active.append(fighter)
	return active

func contains_fighter(fighter: Fighter) -> bool:
	for child in get_children():
		if fighter == child:
			return true
	return false

class_name Party
extends Node

func get_active_fighters() -> Array[Fighter]:
	var active: Array[Fighter] = []
	for fighter in get_children():
		if fighter.active:
			active.append(fighter)
	return active

class_name SpecialEncounter
extends Encounter
# Used for encounters with a predetermined enemy party

@export var enemies: Array[Fighter]

func get_enemies() -> Array[Fighter]:
	return enemies

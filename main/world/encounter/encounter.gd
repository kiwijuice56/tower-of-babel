class_name Encounter
extends Node
# Abstract class that stores a combination of enemies to face in a fight

# Child classes implement `get_enemies()` method with more detail

@export var weight: float

func get_enemies() -> Array[Fighter]:
	return []

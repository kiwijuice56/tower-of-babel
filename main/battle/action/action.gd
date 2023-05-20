class_name Action
extends Node

enum TargetCount {
	SINGLE, ALL, RANDOM, NONE,
}

enum TargetType {
	PLAYER, ENEMY, NONE
}

enum Element {
	NULL = 0,
	PHYSICAL = 1,
	FIRE = 2,
	ICE = 4,
	ELECTRICITY = 8,
	EARTH = 16,
	CELESTIAL = 32,
	HEALING = 64,
	SUPPORT = 128,
	ALMIGHTY = 256,
}

@export_group("Identity")
@export var display_name: String
@export var element: Element

@export_group("Targeting")
@export var target_type: TargetType
@export var target_count: TargetCount 

func commit() -> void:
	pass

class_name Action
extends Node
# Base class for all possible actions within combat


# Selecting NONE for either targeting option will skip the target selection process
# during combat, but is rare and only needed for actions such as Pass

# How many targets that this action can effect; necessary for the UI to select the 
# appropriate amount of targets
enum TargetCount {
	# Random can potentially affect all targets in a party
	NONE, SINGLE, ALL, RANDOM
}

# Whether this action will affect the same or opposing party (ex: healing vs. attacking) 
enum TargetType {
	# SELF_ONLY is for actions such as focusing/charging
	NONE, SAME, SAME_INACTIVE, OTHER, SELF_ONLY
}

enum CostType {
	NONE, HP, SP
}

# Powers of 2 are used in order to represent combinations of elements in a single integer
enum Element {
	NONE = 1,
	PHYSICAL = 2,
	FIRE = 4,
	ICE = 8,
	ELECTRICITY = 16,
	EARTH = 32,
	CELESTIAL = 64,
	HEALING = 128,
	SUPPORT = 256,
	ALMIGHTY = 512,
}

@export_group("Identity")
@export var display_name: String
@export var element: Element
@export_multiline var flavor_text: String

@export_group("Targeting")
@export var target_type: TargetType
@export var target_count: TargetCount 

@export_group("Usage")
@export var battle_ready: bool
@export var overworld_ready: bool
@export var cost_type: CostType
@export var cost: int

var action_owner: Fighter

func commit() -> void:
	pass

func get_description() -> String:
	return flavor_text

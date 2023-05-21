class_name Action
extends Node
# Base class for all possible actions within combat (and also some actions possible 
# in the overworld)

# Selecting NONE for either targeting option will skip the target selection process
# during combat, but is rare and only needed for actions such as passing

# How many targets that this action can effect; necessary for the UI to select the 
# appropriate amount of targets
enum TargetCount {
	# Random can potentially affect all targets in a party, but is not consistent 
	NONE, SINGLE, ALL, RANDOM
}

# Whether this action will affect the same or opposing party (ex: healing vs. attacking) 
enum TargetType {
	# SELF_ONLY is for actions such as focusing/charging
	NONE, SAME, OTHER, SELF_ONLY
}

enum CostType {
	NONE, HP, SP
}

# Powers of 2 are used in order to represent combinations of elements in a single integer
enum Element {
	NONE = 0,
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

@export_group("Usage")
@export var battle_ready: bool
@export var overworld_ready: bool
@export var cost_type: CostType
@export var cost: int

var action_owner: Fighter

func commit() -> void:
	pass

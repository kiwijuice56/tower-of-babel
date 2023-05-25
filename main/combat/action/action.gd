class_name Action
extends Node
# Base class for all possible actions within combat




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
	COMP = 512,
	TALK = 1024,
}

@export_group("Identity")
@export var display_name: String
@export var element: Element
@export_multiline var flavor_text: String

@export_group("Targeting")
@export var target_type: TargetSelector.TargetType
@export var target_count: TargetSelector.TargetCount 
@export var can_target_self: bool 
@export var can_target_party: bool
@export var can_target_active: bool
@export var can_target_inactive: bool

@export_group("Usage")
@export var battle_ready: bool
@export var overworld_ready: bool

var action_owner: Fighter

func commit() -> void:
	pass

func get_description() -> String:
	return flavor_text

func can_use(in_combat: bool) -> bool:
	#var scenario: bool = battle_ready and in_combat or overworld_ready and not in_combat
	var targets: bool = not CommonReference.combat.target_selector.get_possible_targets(self).is_empty()
	return  targets

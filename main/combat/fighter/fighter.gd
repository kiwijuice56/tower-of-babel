class_name Fighter
extends Sprite2D

enum Age {
	CHILD, ADULT, ELDER, ETERNAL,
}

enum Gender {
	MALE, FEMALE, NONBINARY,
}

enum Race {
	# Misc
	HUMAN, ENTITY, FIEND,
	# Light
	DEITY, HOLY, MEGAMI, KISHIN,
	# Neutral
	FEMME, FAIRY, JIRAE, YOMA, BRUTE, NIGHT,
	# Dark
	FALLEN, VILE, WILDER, HAUNT,
}

@export_group("Battle")
@export var level: int
@export var max_health: int 
@export var max_stamina: int

# Physical attack power, critical hit chance
@export var strength: int

# Extra health, ailment resistance, insta-kill resistance  
@export var vitality: int

# Turn order, accuracy, evasion
@export var agility: int

# Small boost to everything chance related, dungeon and battle looting 
@export var luck: int

# Magic attack power, negotiation options
@export var intelligence: int

@export_group("Affinity")
@export_flags("Physical", "Fire", "Ice", "Earth", "Electricity", "Celestial") var weak: int = 0
@export_flags("Physical", "Fire", "Ice", "Earth", "Electricity", "Celestial") var resist: int = 0
@export_flags("Physical", "Fire", "Ice", "Earth", "Electricity", "Celestial") var nullify: int = 0
@export_flags("Physical", "Fire", "Ice", "Earth", "Electricity", "Celestial") var repel: int = 0

@export_group("Identity")
@export var display_name: String
@export var race: Race
@export var age: Age
@export var gender: Gender

var experience: int
var experience_to_level: int
var health: int:
	set(value):
		health_changed.emit(value)
		health = value
var stamina: int:
	set(value):
		stamina_changed.emit(value)
		stamina = value
var active: bool = true

signal health_changed(value)
signal stamina_changed(value)
signal status_changed(value)

func _ready() -> void:
	health = max_health
	stamina = max_stamina
	
	initialize()

# Ensures that all entry methods for skills/status conditions are called correctly
# from either loading a Fighter scene or initializing using save data
func initialize(data: Dictionary = {}) -> void:
	# TODO: Loading skills and status conditions from save data
	if not data.is_empty():
		pass
	
	for action in %Skill.get_children() + %Tactic.get_children() + %Party.get_children():
		action.action_owner = self
	
	for skill in %Skill.get_children():
		learn_skill(skill)
	for status in %StatusConditions.get_children():
		inflict_status_condition(status)

func learn_skill(skill: Skill, idx: int = -1) -> void:
	skill.action_owner = self
	skill.learn()
	if not skill.is_inside_tree():
		%Skill.add_child(skill, idx)

func unlearn_skill(skill: Skill) -> void:
	skill.unlearn()
	skill.action_owner = null
	%Skill.remove_child(skill)

func inflict_status_condition(status: Status) -> void:
	status.status_owner = self
	status.inflict()
	if not status.is_inside_tree():
		%StatusConditions.add_child(status)
	
	status_changed.emit(get_status_conditions())

func recover_status_condition(status: Status) -> void:
	status.recover()
	status.status_owner = null
	%StatusConditions.remove_child(status)
	status.queue_free()
	
	status_changed.emit(get_status_conditions())

func get_status_conditions() -> Array[Status]:
	var condition_list: Array[Status] = []
	condition_list.assign(%StatusConditions.get_children())
	return condition_list

func get_actions(category: String) -> Array[Action]:
	var action_list: Array[Action] = []
	action_list.assign(get_node("Action/" + category).get_children())
	return action_list

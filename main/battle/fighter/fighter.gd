class_name Fighter
extends Sprite2D

enum StatusEffect { 
	DEAD, 
	BLEED, 
	RADIATION, 
	DRUGGED, 
}

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
# This variable must be duplicated in order to call the setter
var status_effects: Array[int]:
	set(value):
		status_changed.emit(value)
		status_effects = value
var active: bool = true

signal health_changed(value)
signal stamina_changed(value)
signal status_changed(value)

func _ready() -> void:
	health = max_health
	stamina = max_stamina
	status_effects = [StatusEffect.BLEED, StatusEffect.RADIATION, StatusEffect.DRUGGED]

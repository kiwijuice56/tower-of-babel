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

var experience: int
var experience_to_level: int
var health: int
var stamina: int

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
@export_flags("Physical", "Fire", "Ice", "Earth", "Electricity", "Celestial") var weaknesses: int = 0

@export_group("Personality")
@export var race: Race
@export var age: Age
@export var gender: Gender

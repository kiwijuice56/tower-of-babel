class_name PointSkill
extends Skill
# Base class for skills that change the health/stamina of a fighter

@export_group("Stats")
@export var power: int
@export_range(0, 100) var accuracy: int = 0
@export_range(0, 100) var critical: int = 0

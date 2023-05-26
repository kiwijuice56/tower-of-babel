class_name World
extends Node
# Root node for overworld/dungeon gameplay, including both 2D and 3D visuals

@onready var player: Player = %Player

signal enabled
signal disabled

func enable() -> void:
	enabled.emit()

func disable() -> void:
	disabled.emit()

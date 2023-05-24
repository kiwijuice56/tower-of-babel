class_name World
extends Node

@onready var player: Player = %Player

signal enabled
signal disabled

func enable() -> void:
	enabled.emit()

func disable() -> void:
	disabled.emit()

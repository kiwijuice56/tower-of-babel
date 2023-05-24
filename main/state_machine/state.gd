class_name State
extends Node

@onready var state_machine: StateMachine = get_parent()

signal entered
signal exited

func process(_delta: float) -> void:
	pass

func input(_event: InputEvent) -> void:
	pass

func act() -> void:
	pass

func enter(_before: State = null, _data: Dictionary = {}) -> void:
	entered.emit()

func exit(_after: State = null, _data: Dictionary = {}) -> void:
	exited.emit()

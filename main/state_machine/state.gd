class_name State
extends Node
# The logic for a single phase of gameplay, including transitions to other states

# See documentation for a full diagram of possible game states

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

class_name State
extends Node

var state_machine: StateMachine

signal entered(data)
signal exited(data)

func enter(_before: State, data: Dictionary = {}) -> void:
	entered.emit(data)

func exit(_after: State, data: Dictionary = {}) -> void:
	exited.emit(data)

func input(_event: InputEvent) -> void:
	pass

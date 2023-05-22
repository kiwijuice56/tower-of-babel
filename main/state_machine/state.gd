class_name State
extends Node

var state_machine: StateMachine

signal entered(data)
signal exited(data)

func enter(before: State, data: Dictionary = {}) -> void:
	entered.emit(data)

func exit(after: State, data: Dictionary = {}) -> void:
	exited.emit(data)

func input(event: InputEvent) -> void:
	pass

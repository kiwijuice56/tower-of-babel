class_name State
extends Node

var state_machine: StateMachine

func enter(before: State, data: Dictionary = {}) -> void:
	pass

func exit(after: State, data: Dictionary = {}) -> void:
	pass

func input(event: InputEvent) -> void:
	pass

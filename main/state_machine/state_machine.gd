class_name StateMachine
extends Node

@export var state_owner: Node
@export var initial_state: State

var current_state: State

func _ready() -> void:
	current_state = initial_state
	for child in get_children():
		assert(child is State)
		child.state_machine = self

func _input(event: InputEvent) -> void:
	current_state.input(event)

func transition_to(target_state: String, data: Dictionary = {}) -> void:
	var old_state: State = current_state
	current_state = get_node(target_state)
	
	await old_state.exit(current_state, data)
	await current_state.enter(old_state, data)

class_name StateMachine
extends Node
# Controls the flow of logic between different game states using a finite stack-based 
# state machine

# See documentation for a full diagram of possible game states

@export var initial_state: State

var state_stack: Array[State]

func _ready() -> void:
	state_stack.append(initial_state)
	
	await get_tree().get_root().ready
	_transition(null, initial_state, {})

func _process(delta: float) -> void:
	state_stack.back().process(delta)

func _input(event: InputEvent) -> void:
	state_stack.back().input(event)

func _transition(before: State, after: State, data: Dictionary) -> void:
	set_process(false)
	set_process_input(false)
	
	# These methods are not necessarily coroutines, depending on the state
	if before != null:
		@warning_ignore("redundant_await")
		await before.exit(after, data)
	@warning_ignore("redundant_await")
	await after.enter(before, data)
	
	set_process(true)
	set_process_input(true)
	
	after.act()

func transition_to(state_name: String, data: Dictionary = {}) -> void:
	var before: State = state_stack.pop_back()
	var after: State = get_node(state_name)
	state_stack.append(after)
	await _transition(before, after, data)

func pop(data: Dictionary = {}) -> void:
	var before: State = state_stack.pop_back()
	var after: State = state_stack.back()
	await _transition(before, after, data)

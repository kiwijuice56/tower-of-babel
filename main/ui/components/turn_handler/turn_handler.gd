class_name TurnIconPanel
extends HBoxContainer
# Handles the press-turn icons at the top of screen during combat

# All methods assume a valid query (removing only when there is > 1 turn, etc.)

const ICON_SCENE: PackedScene = preload("res://main/ui/components/turn_handler/turn_unit/TurnUnit.tscn")

var total_turns: int = 0
var half_turns: int = 0

func _ready() -> void:
	initialize(4)

func initialize(initial_turns: int) -> void:
	await consume_turns(total_turns)
	
	total_turns = initial_turns
	half_turns = 0
	
	var parallel: ParallelCoroutine = ParallelCoroutine.new()
	for turn in total_turns:
		var new_icon: TurnUnit = ICON_SCENE.instantiate()
		%IconContainer.add_child(new_icon)
		parallel.append(new_icon, [], "add", "added")
	
	parallel.run_all()
	await parallel.completed

func halve_turns(to_halve: int) -> void:
	var parallel: ParallelCoroutine = ParallelCoroutine.new()
	for turn in range(total_turns - to_halve - half_turns, total_turns - half_turns):
		parallel.append(%IconContainer.get_child(turn), [], "flash", "flashed")
	
	half_turns += to_halve
	
	parallel.run_all()
	await parallel.completed

func consume_turns(to_consume: int) -> void:
	var parallel: ParallelCoroutine = ParallelCoroutine.new()
	for turn in range(total_turns - to_consume, total_turns):
		parallel.append(%IconContainer.get_child(turn), [], "remove", "removed")
	
	half_turns = max(0, half_turns - to_consume)
	total_turns -= to_consume
	
	parallel.run_all()
	await parallel.completed

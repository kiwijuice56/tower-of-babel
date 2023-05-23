class_name DungeonState
extends State

var can_exit: bool = false

func input(event: InputEvent) -> void:
	if can_exit and event.is_action_pressed("x", false):
		state_machine.transition_to("DungeonMenu")

func enter(before: State, data: Dictionary = {}) -> void:
	super.enter(before, data)
	CommonReference.ui.input_help.append_instructions({"x" : "comp menu"})
	%EncounterRadarBox.visible = true
	can_exit = true

func exit(after: State, data: Dictionary = {}) -> void:
	super.exit(after, data)
	CommonReference.ui.input_help.remove_instructions({"x" : "comp menu"})
	%EncounterRadarBox.visible = false
	can_exit = false

# TODO: connect this with actual battles, likely a parameter will be needed here
func _on_battle_started() -> void:
	state_machine.transition_to("Battle")

class_name DungeonState
extends State

func input(event: InputEvent) -> void:
	if event.is_action_pressed("x"):
		state_machine.transition_to("Pause")

func enter(before: State = null, data: Dictionary = {}) -> void:
	super.enter(before, data)
	CommonReference.world.enable()
	CommonReference.ui.encounter_radar_handler.transition_in()
	CommonReference.ui.input_help_handler.append_instructions({"x" : "comp"})

func exit(after: State = null, data: Dictionary = {}) -> void:
	super.exit(after, data)
	CommonReference.world.disable()
	CommonReference.ui.encounter_radar_handler.transition_out()
	CommonReference.ui.input_help_handler.remove_instructions({"x" : "comp"})

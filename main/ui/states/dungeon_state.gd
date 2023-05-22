class_name DungeonState
extends State

func input(event: InputEvent) -> void:
	if event.is_action_pressed("y", false):
		state_machine.transition_to("DungeonMenu")
	if event.is_action_pressed("x", false):
		_on_battle_started()

func enter(before: State, data: Dictionary = {}) -> void:
	super.enter(before, data)
	%EncounterRadarBox.visible = true

func exit(after: State, data: Dictionary = {}) -> void:
	super.exit(after, data)
	%EncounterRadarBox.visible = false

# TODO: connect this with actual battles, likely a parameter will be needed here
func _on_battle_started() -> void:
	state_machine.transition_to("Battle")

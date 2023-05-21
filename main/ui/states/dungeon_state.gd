class_name DungeonState
extends State

func input(event: InputEvent) -> void:
	if event.is_action_pressed("y", false):
		state_machine.transition_to("DungeonMenu")
	if event.is_action_pressed("x", false):
		_on_battle_started()

func enter(_before: State, _data: Dictionary = {}) -> void:
	%EncounterRadarBox.visible = true

func exit(_after: State, _data: Dictionary = {}) -> void:
	%EncounterRadarBox.visible = false

# TODO: connect this with actual battles, likely a parameter will be needed here
func _on_battle_started() -> void:
	state_machine.transition_to("Battle")

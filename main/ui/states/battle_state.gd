class_name BattleState
extends State

func input(event: InputEvent) -> void:
	if event.is_action_pressed("x", false):
		_on_battle_ended()

func enter(_before: State, _data: Dictionary = {}) -> void:
	%TurnIconPanel.visible = true
	%TextBox.visible = true

func exit(_after: State, _data: Dictionary = {}) -> void:
	%TurnIconPanel.visible = false
	%TextBox.visible = false

# TODO: connect this with actual battles, likely a parameter will be needed here
func _on_battle_ended() -> void:
	state_machine.transition_to("Dungeon")

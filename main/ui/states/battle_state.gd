class_name BattleState
extends State

func input(event: InputEvent) -> void:
	# DEBUG
	if event.is_action_pressed("x", false):
		_on_battle_ended()

func enter(before: State, data: Dictionary = {}) -> void:
	super.enter(before, data)
	%TurnIconPanel.visible = true
	%TextBox.visible = true

func exit(after: State, data: Dictionary = {}) -> void:
	super.exit(after, data)
	%TurnIconPanel.visible = false
	%TextBox.visible = false

# TODO: connect this with actual battles, likely a parameter will be needed here
func _on_battle_ended() -> void:
	state_machine.transition_to("Dungeon")

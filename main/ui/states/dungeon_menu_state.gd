class_name DungeonMenuState
extends State

func input(event: InputEvent) -> void:
	if event.is_action_pressed("y", false):
		%ActionPanel.cancel()
		state_machine.transition_to("Dungeon")

func enter(_before: State, _data: Dictionary = {}) -> void:
	%TextBox.visible = true
	var options: Array[String] = ["Skill", "Item", "COMP", "Option"]
	%ActionPanel.visible = true
	%ActionPanel.query(options)

func exit(_after: State, _data: Dictionary = {}) -> void:
	%ActionPanel.visible = false
	%TextBox.visible = false

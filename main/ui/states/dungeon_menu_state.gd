class_name DungeonMenuState
extends State

func input(event: InputEvent) -> void:
	if event.is_action_pressed("y", false):
		%ActionPanel.cancel()
		state_machine.transition_to("Dungeon")

func enter(before: State, data: Dictionary = {}) -> void:
	super.enter(before, data)
	%TextBox.visible = true
	var options: Array[String] = ["Skill", "Item", "COMP", "Option"]
	%ActionPanel.visible = true
	%ActionPanel.query_action(options)

func exit(after: State, data: Dictionary = {}) -> void:
	super.exit(after, data)
	%ActionPanel.visible = false
	%TextBox.visible = false

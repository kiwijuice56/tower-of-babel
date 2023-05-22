class_name DungeonMenuState
extends State

func input(event: InputEvent) -> void:
	if event.is_action_pressed("y", false):
		%ActionPanel.cancel()
		state_machine.transition_to("Dungeon")

func enter(before: State, data: Dictionary = {}) -> void:
	super.enter(before, data)
	
	await %TextBox.transition_in()
	%TextBox.display_text("Your COMP whirred to life.", TextBox.TextSpeed.FAST, false)
	var options: Array[String] = ["Skill", "Item", "Demon", "Option"]
	%ActionPanel.visible = true
	var action: String = await %ActionPanel.query_action(options)
	if action == "":
		return

func exit(after: State, data: Dictionary = {}) -> void:
	super.exit(after, data)
	%ActionPanel.visible = false
	await %TextBox.transition_out()

class_name DungeonMenuState
extends State

func enter(before: State, data: Dictionary = {}) -> void:
	super.enter(before, data)
	
	CommonReference.ui.input_help.append_instructions({"b" : "back"})
	
	if before is DungeonState:
		await %TextBox.transition_in()
		%TextBox.display_text("Your COMP whirred to life.", TextBox.TextSpeed.FAST, false)
	else:
		%TextBox.display_text("Your COMP is humming steadily.", TextBox.TextSpeed.FAST, false)
	
	var initial_select: int = 0
	if before is DemonState:
		initial_select = 2
	
	var options: Array[String] = ["Skill", "Item", "Demon", "Option"]
	var action: String = await %ActionPanel.query_action(options, true, initial_select)
	
	match action:
		"": 
			state_machine.transition_to("Dungeon")
		"Demon":
			state_machine.transition_to("Demon")

func exit(after: State, data: Dictionary = {}) -> void:
	super.exit(after, data)
	if after is DungeonState:
		await %TextBox.transition_out()
	CommonReference.ui.input_help.remove_instructions({"b" : "back"})


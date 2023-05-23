class_name DemonState
extends State

var choices: Dictionary

func enter(before: State, data: Dictionary = {}) -> void:
	super.enter(before, data)
	
	if before is DungeonMenuState:
		choices = {"a" : "summon", "x": "check", "y": "kill"}
	if before is BattleState:
		choices = {"a" : "summon", "y": "check"}
	
	CommonReference.ui.input_help.append_instructions({"left_right" : "select"})
	CommonReference.ui.input_help.append_instructions(choices)
	
	%TextBox.display_text("What will you do with your demons?", TextBox.TextSpeed.FAST, false)
	await %DemonContainer.transition_in()
	
	
	var selection: Array = await %DemonContainer.select_inactive_fighter(choices)
	match selection[1]:
		"back":
			if before is DungeonMenuState:
				state_machine.transition_to("DungeonMenu")

func exit(_after: State, _data: Dictionary = {}) -> void:
	%TextBox.clear()
	await %DemonContainer.transition_out()
	
	CommonReference.ui.input_help.remove_instructions({"left_right" : "select"})
	CommonReference.ui.input_help.remove_instructions(choices)

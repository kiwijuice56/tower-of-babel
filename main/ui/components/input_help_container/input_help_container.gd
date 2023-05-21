class_name InputHelpContainer
extends MarginContainer
# Displays possible actions and their associated keys/buttons at the bottom of the screen

@export var key_color: Color
@export var action_color: Color

var all_input: Dictionary

func append_instructions(input: Dictionary) -> void:
	all_input.merge(input)
	update_text() 

func remove_instructions(input: Dictionary) -> void:
	for action in input:
		all_input.erase(action)
	update_text() 

func update_text() -> void:
	clear()
	for action in all_input:
		var primary_event: InputEvent = InputMap.action_get_events(action)[0]
		%InputLabel.append_text(TextColor.get_colored_text("-" + primary_event.as_text().substr(0, 1), key_color))
		%InputLabel.append_text(TextColor.get_colored_text(" " + all_input[action] + " ", action_color))

func clear() -> void:
	%InputLabel.clear()

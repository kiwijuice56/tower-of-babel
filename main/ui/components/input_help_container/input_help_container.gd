class_name InputHelpContainer
extends MarginContainer

@export var key_color: Color
@export var action_color: Color

func _ready() -> void:
	display({"ui_left" : "this", "ui_accept" : "that"})

func display(input: Dictionary) -> void:
	clear()
	for action in input:
		var primary_event: InputEvent = InputMap.action_get_events(action)[0]
		%InputLabel.append_text(TextColor.get_colored_text("-" + primary_event.as_text(), key_color))
		%InputLabel.append_text(TextColor.get_colored_text(" " + input[action] + " ", action_color))

func clear() -> void:
	%InputLabel.clear()

class_name TextColor
extends Node

static func get_colored_text(s: String, color: Color) -> String:
	return "[color=" + color.to_html(false) + "]" + s + "[/color]"

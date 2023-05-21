class_name SubactionPanel
extends MarginContainer
# Handles specific item and skill prompts

var action_arrays: Array[Array]
var titles: Array[String]
var icons: Array[Resource]

func _ready() -> void:
	set_process_input(false)



func query(action_arrays: Array[Array], titles: Array[String], icons: Array[Resource], can_cancel: bool = false, initial_select: int = 0) -> Action:
	self.action_arrays = action_arrays
	self.titles = titles
	self.icons = icons
	
	return null

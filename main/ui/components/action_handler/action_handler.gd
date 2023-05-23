class_name ActionHandler
extends MarginContainer
# Handles specific item and skill prompts

var action_arrays: Array[Array]
var titles: Array[String]
var icons: Array[Resource]

func _ready() -> void:
	set_process_input(false)

func query_subaction(action_arrays: Array[Array], titles: Array[String], icons: Array[Resource], _can_cancel: bool = false, _initial_select: int = 0) -> Action:
	self.action_arrays = action_arrays
	self.titles = titles
	self.icons = icons
	
	return null

func transition_in() -> void:
	pass

func transition_out() -> void:
	pass

class_name SubactionPanel
extends MarginContainer
# Handles specific item and skill prompts

func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel", false):
		button_pressed.emit("_cancel")

func query(action_bundles: Array[Array], titles: Array[String], icons: Array[Resource], can_cancel: bool = false, initial_select: int = 0) -> Action:
	# 

class_name ActionPanel
extends HBoxContainer
# Handles queries of basic choices for the player, such as dialogue or navigating the COMP menu

const ACTION_BUTTON_SCENE: PackedScene = preload("res://main/ui/components/action_panel/ActionButton.tscn")

@export var scale_time: float = 0.03

signal button_pressed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("b"):
		button_pressed.emit("")

# Option strings must be unique
func query_action(options: Array[String], can_cancel: bool = false, initial_select: int = 0) -> String:
	for button in %ButtonContainer.get_children():
		%ButtonContainer.remove_child(button)
		button.queue_free()
	for option in range(len(options)):
		var new_button: Button = ACTION_BUTTON_SCENE.instantiate()
		%ButtonContainer.add_child(new_button)
		
		# Prevent focus from leaving the action panel 
		# Without this, the buttons will automatically target other available controls
		new_button.set_focus_neighbor(SIDE_TOP, ".")
		new_button.set_focus_neighbor(SIDE_BOTTOM, ".")
		
		new_button.name = options[option]
		new_button.text = options[option]
		new_button.pressed.connect(emit_signal.bind("button_pressed", options[option]))
	var first_button: Button = %ButtonContainer.get_child(0)
	var last_button: Button = %ButtonContainer.get_child(-1)
	first_button.set_focus_neighbor(SIDE_LEFT, first_button.get_path_to(last_button))
	last_button.set_focus_neighbor(SIDE_RIGHT, last_button.get_path_to(first_button))
	
	visible = true
	scale.y = 0.0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale:y", 1.0, scale_time)
	await tween.finished
	
	set_process_input(can_cancel)
	
	%ButtonContainer.get_child(initial_select).grab_focus()
	var selected_option: String = await button_pressed
	
	set_process_input(false)
	
	scale.y = 1.0
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale:y", 0.0, scale_time)
	await tween.finished
	visible = false
	
	return selected_option

func cancel() -> void:
	button_pressed.emit("")

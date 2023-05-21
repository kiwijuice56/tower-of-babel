class_name ActionPanel
extends HBoxContainer
# Handles queries of basic choices for the player, such as dialogue or navigating the COMP menu

const ACTION_BUTTON_SCENE: PackedScene = preload("res://main/ui/components/action_panel/ActionButton.tscn")

@export var scale_time: float = 0.05

signal button_pressed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("y", false):
		button_pressed.emit("")

func query(options: Array[String], initial_select: int = 0) -> String:
	for button in %ButtonContainer.get_children():
		%ButtonContainer.remove_child(button)
		button.queue_free()
	for option in range(len(options)):
		var new_button: Button = ACTION_BUTTON_SCENE.instantiate()
		# Allows focus to cycle left and right
		# Bug: Will not work unless the neighbor is set before the button is added to the scene
		if option == 0:
			new_button.set_focus_neighbor(SIDE_LEFT, "../" + options[-1])
		elif option == len(options) - 1:
			new_button.set_focus_neighbor(SIDE_RIGHT, "../" + options[0])
		
		new_button.name = options[option]
		new_button.text = options[option]
		new_button.pressed.connect(emit_signal.bind("button_pressed", options[option]))
		
		%ButtonContainer.add_child(new_button)
	
	scale.y = 0.0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale:y", 1.0, scale_time)
	await tween.finished
	
	%ButtonContainer.get_child(initial_select).grab_focus()
	var selected_option: String = await button_pressed
	
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale:y", 0.0, scale_time)
	await tween.finished
	
	return selected_option

func cancel() -> void:
	button_pressed.emit(null)

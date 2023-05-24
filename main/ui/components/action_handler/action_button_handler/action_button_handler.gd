class_name ActionButtonHandler
extends ScrollContainer

const ACTION_BUTTON_SCENE: PackedScene = preload("res://main/ui/components/action_handler/action_button/ActionButton.tscn")

func initialize(actions: Array[Action], in_combat: bool) -> void:
	for action in actions:
		var button: ActionButton = ACTION_BUTTON_SCENE.instantiate()
		%ButtonContainer.add_child(button)
		button.initialize(action, in_combat)
	var first_button: Button = %ButtonContainer.get_child(0)
	var last_button: Button = %ButtonContainer.get_child(-1)
	first_button.set_focus_neighbor(SIDE_TOP, first_button.get_path_to(last_button))
	last_button.set_focus_neighbor(SIDE_BOTTOM, last_button.get_path_to(first_button))

func get_action_buttons() -> Array[ActionButton]:
	@warning_ignore("unassigned_variable")
	var buttons: Array[ActionButton]
	buttons.assign(%ButtonContainer.get_children())
	return buttons

func button_grab_focus(idx: int) -> void:
	# The automatic focus happens first without the call_deferred
	%ButtonContainer.get_child(idx).call_deferred("grab_focus")

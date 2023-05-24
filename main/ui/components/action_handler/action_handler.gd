class_name ActionHandler
extends MarginContainer
# Handles specific item and skill prompts

const ACTION_CONTAINER_SCENE: PackedScene = preload("res://main/ui/components/action_handler/action_container/ActionContainer.tscn")
const ACTION_BUTTON_SCENE: PackedScene = preload("res://main/ui/components/action_handler/action_button/ActionButton.tscn")

@export var scale_time: float = 0.06

var fighters: Array[Fighter]
var can_switch_fighters: bool

signal completed
signal button_pressed(action)

func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("b"):
		button_pressed.emit(null)
	if can_switch_fighters and event.is_action_pressed("left", false):
		var new_tab: int = %TabContainer.current_tab - 1
		if new_tab < 0:
			new_tab = len(fighters) - 1
		switch_fighter(new_tab, true)
	if can_switch_fighters and event.is_action_pressed("right", false):
		var new_tab: int = (%TabContainer.current_tab + 1) % len(fighters)
		switch_fighter(new_tab, true)

func initialize(fighters: Array[Fighter], category: String, initial_fighter: int, can_switch_fighters: bool) -> void:
	self.fighters = fighters
	self.can_switch_fighters = can_switch_fighters
	
	for container in %TabContainer.get_children():
		%TabContainer.remove_child(container)
		container.queue_free()
	
	for fighter in fighters:
		var container: ActionContainer = ACTION_CONTAINER_SCENE.instantiate()
		
		%TabContainer.add_child(container)
		for action in fighter.get_node(category).get_children():
			var button: ActionButton = ACTION_BUTTON_SCENE.instantiate()
			container.button_container.add_child(button)
			button.initialize(action)
			button.pressed.connect(emit_signal.bind("button_pressed", action))
		var first_button: Button = container.button_container.get_child(0)
		var last_button: Button = container.button_container.get_child(-1)
		first_button.set_focus_neighbor(SIDE_TOP, first_button.get_path_to(last_button))
		last_button.set_focus_neighbor(SIDE_BOTTOM, last_button.get_path_to(first_button))
	switch_fighter(initial_fighter)

func switch_fighter(tab: int, focus_button: bool = false) -> void:
	%TabContainer.current_tab = tab
	%TabTitleLabel.text = fighters[tab].display_name
	%FighterIcon.texture = fighters[tab].texture
	
	if focus_button:
		# The automatic focus happens first without the call_deferred
		get_current_button_container().get_child(0).call_deferred("grab_focus")

func query_action(initial_select: int) -> Action:
	set_process_input(true)
	
	var instructions: Dictionary = {"a" : "accept", "_up_down": "select", "b" : "cancel"}
	if can_switch_fighters:
		instructions.merge({"_left_right" : "next demon"})
	CommonReference.ui.input_help_handler.append_instructions(instructions)
	
	get_current_button_container().get_child(initial_select).grab_focus()
	var selected_option: Action = await button_pressed
	
	set_process_input(false)
	
	CommonReference.ui.input_help_handler.remove_instructions(instructions)
	return selected_option

func get_current_button_container() -> VBoxContainer:
	return %TabContainer.get_child(%TabContainer.current_tab).button_container

func transition_in() -> void:
	visible = true
	scale.y = 0.0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale:y", 1.0, scale_time)
	await tween.finished
	
	completed.emit()

func transition_out() -> void:
	visible = true
	scale.y = 1.0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "scale:y", 0.0, scale_time)
	await tween.finished
	
	completed.emit()

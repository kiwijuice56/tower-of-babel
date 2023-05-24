class_name ActionHandler
extends MarginContainer
# Handles specific item and skill prompts

const ACTION_BUTTON_HANDLER_SCENE: PackedScene = preload("res://main/ui/components/action_handler/action_button_handler/ActionButtonHandler.tscn")


@export var scale_time: float = 0.06

var fighters: Array[Fighter]
var can_swap: bool

signal completed
signal button_pressed(action)

func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("b"):
		button_pressed.emit(null)
	if can_swap and event.is_action_pressed("left", false):
		var new_tab: int = %TabContainer.current_tab - 1
		if new_tab < 0:
			new_tab = len(fighters) - 1
		switch_fighter(new_tab, true)
	if can_swap and event.is_action_pressed("right", false):
		var new_tab: int = (%TabContainer.current_tab + 1) % len(fighters)
		switch_fighter(new_tab, true)

func initialize(fighters: Array[Fighter], category: String, initial_fighter: int, in_combat: bool) -> void:
	self.fighters = fighters
	can_swap = not in_combat
	
	%TabInfoContainer.visible = can_swap
	
	for handler in %TabContainer.get_children():
		handler.queue_free()
	
	for fighter in fighters:
		var handler: ActionButtonHandler = ACTION_BUTTON_HANDLER_SCENE.instantiate()
		%TabContainer.add_child(handler)
		
		@warning_ignore("unassigned_variable")
		var actions: Array[Action]
		actions.assign(fighter.get_node(category).get_children())
		handler.initialize(actions, in_combat)
		
		for button in handler.get_action_buttons():
			button.pressed.connect(emit_signal.bind("button_pressed", button.action))
	switch_fighter(initial_fighter)

func switch_fighter(tab: int, focus_button: bool = false) -> void:
	%TabContainer.current_tab = tab
	%TabTitleLabel.text = fighters[tab].display_name
	%FighterIcon.texture = fighters[tab].texture
	
	if focus_button:
		get_current_handler().button_grab_focus(0)

func query_action(initial_select: int) -> Action:
	set_process_input(true)
	
	var instructions: Dictionary = {"a" : "accept", "_up_down": "select", "b" : "cancel"}
	if can_swap:
		instructions.merge({"_left_right" : "next demon"})
	CommonReference.ui.input_help_handler.append_instructions(instructions)
	
	get_current_handler().button_grab_focus(initial_select)
	var selected_option: Action = await button_pressed
	
	set_process_input(false)
	
	CommonReference.ui.input_help_handler.remove_instructions(instructions)
	return selected_option

func get_current_handler() -> ActionButtonHandler:
	return %TabContainer.get_child(%TabContainer.current_tab)

func transition_in() -> void:
	visible = true
	pivot_offset.y = size.y
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

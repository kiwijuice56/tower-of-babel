class_name DemonContainer
extends VBoxContainer
# Handles all queries related to selecting demons in a party

# This script has some redundancy, but I won't prioritize cleaning it up right now

const FIGHTER_PANEL_SCENE: PackedScene = preload("res://main/ui/components/fighter_panel/FighterPanel.tscn")
const FINAL_HEIGHT: int = 73

@export var scale_time: float = 0.06

signal fighter_selected(fighter, hotkey)

var hotkeys: Dictionary

func _ready() -> void:
	if not CommonReference.party.is_inside_tree():
		await CommonReference.party.ready
	CommonReference.party.child_entered_tree.connect(_on_party_updated)
	CommonReference.party.child_exiting_tree.connect(_on_party_updated)
	%StockHolder.visible = false
	%StockHolder.custom_minimum_size.y = 0
	
	_on_party_updated(null)

# This process should only be enabled when a fighter panel is on focus
# Because other hotkeys other than accept are used when hovering over fighters, I opted 
# for using input events and signals
func _input(event: InputEvent) -> void:
	for hotkey in hotkeys:
		if event.is_action(hotkey):
			var panel: FighterPanel = get_viewport().gui_get_focus_owner().get_parent()
			fighter_selected.emit([panel.fighter, hotkeys[hotkey]])

func _on_party_updated(_node: Node) -> void:
	# Prevent the UI from updating when the game is closing (demons are deleted on close?)
	if not is_inside_tree():
		return
	
	# Clear out all old panels
	for panel in %ActivePartyContainer.get_children():
		%ActivePartyContainer.remove_child(panel)
		panel.queue_free()
	for panel in %InactivePartyContainer.get_children():
		%InactivePartyContainer.remove_child(panel)
		panel.queue_free()
	
	update_active_party()
	update_inactive_party()

func _on_fighter_selected(fighter: Fighter) -> void:
	fighter_selected.emit(fighter)

func update_active_party() -> void:
	for fighter in CommonReference.party.get_children():
		# Inactive fighters should not be a part of the main party
		if not fighter.active:
			continue
		var new_panel: FighterPanel = FIGHTER_PANEL_SCENE.instantiate()
		
		%ActivePartyContainer.add_child(new_panel)
		
		new_panel.button.set_focus_neighbor(SIDE_TOP, ".")
		new_panel.button.set_focus_neighbor(SIDE_BOTTOM, ".")
		new_panel.button.button_down.connect(_on_fighter_selected.bind(fighter))
		new_panel.initialize(fighter)
	
	var first_button: Button = %ActivePartyContainer.get_child(0).button
	var last_button: Button = %ActivePartyContainer.get_child(-1).button
	first_button.set_focus_neighbor(SIDE_LEFT, first_button.get_path_to(last_button))
	last_button.set_focus_neighbor(SIDE_RIGHT, last_button.get_path_to(first_button))
	
	# Fill out any empty slots
	for empty_slot in range(4 - %ActivePartyContainer.get_child_count()):
		var new_panel: FighterPanel = FIGHTER_PANEL_SCENE.instantiate()
		%ActivePartyContainer.add_child(new_panel)
		new_panel.initialize(null)

func update_inactive_party() -> void:
	for fighter in CommonReference.party.get_children():
		var new_panel: FighterPanel = FIGHTER_PANEL_SCENE.instantiate()
		
		%InactivePartyContainer.add_child(new_panel)
		
		new_panel.button.set_focus_neighbor(SIDE_TOP, ".")
		new_panel.button.set_focus_neighbor(SIDE_BOTTOM, ".")
		
		new_panel.button.button_down.connect(_on_fighter_selected.bind(fighter))
		new_panel.initialize(fighter, fighter.active)
	var first_button: Button = %InactivePartyContainer.get_child(0).button
	var last_button: Button = %InactivePartyContainer.get_child(-1).button
	first_button.set_focus_neighbor(SIDE_LEFT, first_button.get_path_to(last_button))
	last_button.set_focus_neighbor(SIDE_RIGHT, last_button.get_path_to(first_button))

# Since the player can perform multiple actions when selecting inactive party menbers 
# (such as checking, summoning, killing), this method is implemented to support
# different combinations of hotkeys
func select_inactive_fighter(input: Dictionary) -> Array:
	set_process_input(true)
	
	hotkeys = input
	
	%InactivePartyContainer.get_child(0).button.grab_focus()
	var selection: Array = await fighter_selected
	get_viewport().gui_get_focus_owner().release_focus()
	
	set_process_input(false)
	
	return selection

# Assumes the first demon in the stock is active, and that there are > 0 active demons
func select_active_fighter() -> Fighter:
	set_process_input(true)
	
	%ActivePartyContainer.get_child(0).button.grab_focus()
	var fighter: Fighter = (await fighter_selected)[0]
	get_viewport().gui_get_focus_owner().release_focus()
	
	set_process_input(false)
	
	return fighter

func transition_in() -> void:
	%StockHolder.visible = true
	%StockHolder.custom_minimum_size.y = 0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(%StockHolder, "custom_minimum_size:y", FINAL_HEIGHT, scale_time)
	await tween.finished

func transition_out() -> void:
	%StockHolder.custom_minimum_size.y = FINAL_HEIGHT
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(%StockHolder, "custom_minimum_size:y", 0, scale_time)
	await tween.finished
	%StockHolder.visible = false

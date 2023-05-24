class_name PartyHandler
extends VBoxContainer
# Handles all queries related to selecting demons in a party

# This script has some redundancy, but I won't prioritize cleaning it up right now

const FIGHTER_HANDLER_SCENE: PackedScene = preload("res://main/ui/components/fighter_handler/FighterHandler.tscn")
const FINAL_HEIGHT: int = 73

@export var scale_time: float = 0.06

signal fighter_selected(fighter)

var hotkeys: Dictionary

func _ready() -> void:
	await get_tree().get_root().ready
	CommonReference.combat.party.child_entered_tree.connect(_on_party_updated)
	CommonReference.combat.party.child_exiting_tree.connect(_on_party_updated)
	%StockHolder.visible = false
	%StockHolder.custom_minimum_size.y = 0
	
	_on_party_updated(null)

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
	var active_count: int = 0
	for fighter in CommonReference.combat.party.get_children():
		if not fighter.active:
			continue
		active_count += 1
		var new_handler: FighterHandler = FIGHTER_HANDLER_SCENE.instantiate()
		%ActivePartyContainer.add_child(new_handler)
		new_handler.button.button_down.connect(_on_fighter_selected.bind(fighter))
		new_handler.initialize(fighter)
	
	var first_button: Button = %ActivePartyContainer.get_child(0).button
	var last_button: Button = %ActivePartyContainer.get_child(active_count - 1).button
	first_button.set_focus_neighbor(SIDE_LEFT, first_button.get_path_to(last_button))
	last_button.set_focus_neighbor(SIDE_RIGHT, last_button.get_path_to(first_button))
	
	# Fill out any empty slots
	for empty_slot in range(4 - %ActivePartyContainer.get_child_count()):
		var new_panel: FighterHandler = FIGHTER_HANDLER_SCENE.instantiate()
		%ActivePartyContainer.add_child(new_panel)
		new_panel.initialize(null)

func update_inactive_party() -> void:
	for fighter in CommonReference.combat.party.get_children():
		var new_handler: FighterHandler = FIGHTER_HANDLER_SCENE.instantiate()
		%InactivePartyContainer.add_child(new_handler)
		new_handler.button.button_down.connect(_on_fighter_selected.bind(fighter))
		new_handler.initialize(fighter, fighter.active)
	var first_button: Button = %InactivePartyContainer.get_child(0).button
	var last_button: Button = %InactivePartyContainer.get_child(-1).button
	first_button.set_focus_neighbor(SIDE_LEFT, first_button.get_path_to(last_button))
	last_button.set_focus_neighbor(SIDE_RIGHT, last_button.get_path_to(first_button))

func select_fighter(active: bool) -> Fighter:
	set_process_input(true)
	
	var container: HBoxContainer = %ActivePartyContainer if active else %InactivePartyContainer
	
	container.get_child(0).button.grab_focus()
	var selection: Fighter = await fighter_selected
	get_viewport().gui_get_focus_owner().release_focus()
	
	set_process_input(false)
	
	return selection

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

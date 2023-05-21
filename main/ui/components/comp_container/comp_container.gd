class_name CompContainer
extends VBoxContainer

const FIGHTER_PANEL_SCENE: PackedScene = preload("res://main/ui/components/fighter_panel/FighterPanel.tscn")

func _ready() -> void:
	CommonReference.party.child_entered_tree.connect(_on_party_updated)
	CommonReference.party.child_exiting_tree.connect(_on_party_updated)
	
	_on_party_updated(null)

func _on_party_updated(_node: Node) -> void:
	for panel in %ActivePartyContainer.get_children():
		%ActivePartyContainer.remove_child(panel)
		panel.queue_free()
	for fighter in CommonReference.party.get_children():
		if not fighter.active or fighter.status_effects.find(Fighter.StatusEffect.DEAD) != -1:
			continue
		var new_panel: FighterPanel = FIGHTER_PANEL_SCENE.instantiate()
		%ActivePartyContainer.add_child(new_panel)
		new_panel.initialize(fighter)
	for empty_slot in range(4 - %ActivePartyContainer.get_child_count()):
		var new_panel: FighterPanel = FIGHTER_PANEL_SCENE.instantiate()
		%ActivePartyContainer.add_child(new_panel)
		new_panel.initialize(null)

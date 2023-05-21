class_name FighterPanel
extends PanelContainer
# Displays the status of a demon in the player's party, updating dynamically during
# battle

var fighter_owner: Fighter

func initialize(fighter: Fighter) -> void:
	fighter_owner = fighter
	
	# TODO: implement more details as the Fighter code is fleshed out
	
	if fighter_owner == null:
		%DataContainer.visible = false
		%EmptyLabel.visible = true

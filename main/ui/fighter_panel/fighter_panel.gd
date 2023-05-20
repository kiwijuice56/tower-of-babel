class_name FighterPanel
extends PanelContainer

var fighter_owner: Fighter

func initialize(fighter: Fighter) -> void:
	fighter_owner = fighter
	if fighter_owner == null:
		%DataContainer.visible = false
		%EmptyLabel.visible = true

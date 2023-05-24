class_name EncounterRadarHandler
extends PanelContainer

signal completed

func transition_in() -> void:
	visible = true
	completed.emit()

func transition_out() -> void:
	visible = false
	completed.emit()

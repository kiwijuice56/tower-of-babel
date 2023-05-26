class_name Status
extends Node
# Temporary changes to fighter state, affecting its stats or ability to perform 
# certain actions

# Composition allows for an easy process to create status effects and more flexibility
# in their functionality

@export_group("Identity")
@export var display_name: String
@export var icon: Resource 

var status_owner: Fighter

func inflict() -> void:
	pass

func recover() -> void:
	pass

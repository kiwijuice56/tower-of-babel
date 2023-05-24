class_name Status
extends Node

@export_group("Identity")
@export var display_name: String
@export var icon: Resource 

var status_owner: Fighter

func inflict() -> void:
	pass

func recover() -> void:
	pass

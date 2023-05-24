extends Node
# Stores references to the top-level nodes

# Note: references will be null if called during the ready process; in that case,
# await the ready for the node you want to access

@onready var ui: UI = get_tree().get_root().get_node("Main/UI")
@onready var combat: Combat = get_tree().get_root().get_node("Main/Combat")
@onready var world: World = get_tree().get_root().get_node("Main/World")

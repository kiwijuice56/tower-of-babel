extends Node
# Stores references to the top-level nodes

# Note: references can be null if called during the ready process; if a node must be
# accessed, `await get_tree().get_root().ready` first

@onready var ui: UI = get_tree().get_root().get_node("Main/UI")
@onready var combat: Combat = get_tree().get_root().get_node("Main/Combat")
@onready var world: World = get_tree().get_root().get_node("Main/World")

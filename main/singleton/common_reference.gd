extends Node
# Stores references to extremely common nodes

# Although this isn't a very proper solution, accessing references this way is much
# cleaner and shorter. Countless nodes across the entire game need access to nodes such
# as UI, so it is unrealistic to use DI or signaling up in every case 

@onready var ui: UI = get_tree().get_root().get_node("Main/ViewportContainer/Viewport/UI")
@onready var party: Party = get_tree().get_root().get_node("Main/PlayerParty")

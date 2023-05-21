extends Node
# Stores references to extremely common nodes

# Although this isn't as "proper" as other solutions such as using signals, this is much
# cleaner and shorter. Countless nodes across the entire game need access to nodes such
# as UI, so it is unrealistic to use DI or "signaling up" 

@onready var ui: UI = get_tree().get_root().get_node("Main/ViewportContainer/Viewport/UI")

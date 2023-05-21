class_name UI
extends Control

# References to commonly used components for easy external access
# Other nodes could technically use the % symbol, but this allows me to debug with
# setget (if needed) and also allows Godot to pick up type hints
@onready var input_help: InputHelpContainer = %InputHelpContainer
@onready var text_box: TextBox = %TextBox

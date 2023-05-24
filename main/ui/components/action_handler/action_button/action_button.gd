class_name ActionButton
extends Button
# Buttons for specific actions, such as skills and items (with costs, icons, etc.)

@export var hp_color: Color
@export var sp_color: Color

var action: Action

func _ready() -> void:
	set_focus_neighbor(SIDE_LEFT, ".")
	set_focus_neighbor(SIDE_RIGHT, ".")
	focus_entered.connect(_on_focus_entered)

func _on_focus_entered() -> void:
	CommonReference.ui.text_handler.display_text(action.get_description(), TextHandler.TextSpeed.FAST, false)

func initialize(action: Action) -> void:
	self.action = action
	
	%CostLabel.text = str(action.cost)
	match action.cost_type:
		action.CostType.NONE:
			%CostLabel.visible = false
		action.CostType.HP:
			%CostLabel.set("theme_override_colors/font_color", hp_color)
			%CostLabel.text += "h"
		action.CostType.SP:
			%CostLabel.set("theme_override_colors/font_color", sp_color)
			%CostLabel.text += "s"
	if action.element == action.Element.NONE:
		%AffinityIcon.visible = false
	%AffinityIcon.initialize(action.element)
	%NameLabel.text = action.display_name

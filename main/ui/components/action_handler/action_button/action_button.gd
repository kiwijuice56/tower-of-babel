class_name ActionButton
extends Button
# Buttons for specific actions, such as skills and items (with costs, icons, etc.)

@export var hp_color: Color
@export var sp_color: Color

var action: Action

func initialize(action: Action) -> void:
	self.action = action
	
	%CostLabel.text = str(action.cost)
	match action.cost_type:
		action.CostType.NONE:
			%CostLabel.visible = false
		action.CostType.HP:
			%CostLabel.add_color_override("font_color", hp_color)
			%CostLabel.text += "h"
		action.CostType.SP:
			%CostLabel.add_color_override("font_color", sp_color)
			%CostLabel.text += "s"
	if action.element == action.Element.NONE:
		%AffinityIcon.visible = false
	%AffinityIcon.set_element(action.element)
	%NameLabel.text = action.display_name

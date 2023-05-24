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

func initialize(action: Action, in_combat: bool) -> void:
	self.action = action
	
	disabled = not action.can_use(in_combat)
	%DisabledCover.visible = disabled
	
	# I could use a SkillButton class intead, but the difference is too small for it 
	# to be worth the extra code
	if action is Skill:
		var skill: Skill = action as Skill
		%CostLabel.text = str(skill.get_cost())
		match skill.cost_type:
			skill.CostType.NONE:
				%CostLabel.visible = false
			skill.CostType.HP:
				%CostLabel.set("theme_override_colors/font_color", hp_color)
				%CostLabel.text += "h"
			skill.CostType.SP:
				%CostLabel.set("theme_override_colors/font_color", sp_color)
				%CostLabel.text += "s"
	else:
		%CostLabel.visible = false
	
	if action.element == action.Element.NONE:
		%AffinityIcon.visible = false
	
	%AffinityIcon.initialize(action.element)
	%NameLabel.text = action.display_name

class_name Skill
extends Action
# Base class for learnable/fusible actions on a fighter

@export_group("Cost")
@export var cost_type: CostType
@export var cost: int

func get_cost() -> int:
	if cost_type == CostType.SP:
		return cost
	if cost_type == CostType.HP:
		return ceil(action_owner.max_health * (cost / 100.0))
	return 0

func can_use(in_combat: bool) -> bool:
	if not super.can_use(in_combat):
		return false
	if cost_type == CostType.SP and get_cost() > action_owner.stamina:
		return false
	if cost_type == CostType.HP and get_cost() > action_owner.health:
		return false
	return true

func learn() -> void:
	pass

func unlearn() -> void:
	pass

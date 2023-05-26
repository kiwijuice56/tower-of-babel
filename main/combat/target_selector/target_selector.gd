class_name TargetSelector
extends Node
# Handles the selection of targets in either enemy and player parties for action usage

# Selecting NONE for either targeting option will skip the target selection process
# during combat, but is rare and only needed for actions such as Pass

# How many targets that this action can effect; necessary for the UI to select the 
# appropriate amount of targets
enum TargetCount {
	# Random can potentially affect all targets in a party
	NONE, SINGLE, ALL, RANDOM
}

# Whether this action will affect the same or opposing party (ex: healing vs. attacking) 
enum TargetType {
	NONE,
	SAME,
	OTHER,
}

func get_possible_targets(action: Action) -> Array[Fighter]:
	var is_player: bool = %PlayerParty.contains_fighter(action.action_owner)
	var party: Party
	if is_player and action.target_type == TargetType.OTHER or not is_player and action.target_type == TargetType.SAME:
		party = %EnemyParty
	else:
		party = %PlayerParty
	
	var targets: Array[Fighter] = []
	
	for fighter in party.get_children():
		if action.target_type == TargetType.SAME:
			if action.action_owner == fighter and not action.can_target_self:
				continue
			if action.action_owner != fighter and not action.can_target_party:
				continue
		if action.can_target_active and fighter.active or action.can_target_inactive and not fighter.active:
			targets.append(fighter)
	
	return targets

func select_target(_action: Action) -> Fighter:
	# TODO: prompt UI
	return null

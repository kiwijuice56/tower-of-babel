class_name PauseState
extends State

@export var flavor_idle_comp: Array[String]

func act() -> void:
	var choice: String = await CommonReference.ui.choice_handler.query_choice(true, 0)
	match choice:
		"":
			state_machine.transition_to("Dungeon")
		"Skill", "Tactic", "Party":
			CommonReference.ui.action_handler.initialize(CommonReference.combat.party.get_active_fighters(), choice, 0, false)
			CommonReference.ui.text_handler.clear()
			
			var parallel: ParallelCoroutine = ParallelCoroutine.new()
			parallel.append(CommonReference.ui.action_handler, [], "transition_in", "completed")
			parallel.append(CommonReference.ui.choice_handler, [], "transition_out", "completed")
			parallel.run_all()
			await parallel.completed
			
			var action: Action = await CommonReference.ui.action_handler.query_action(0)
			
			if action == null:
				parallel = ParallelCoroutine.new()
				parallel.append(CommonReference.ui.action_handler, [], "transition_out", "completed")
				parallel.append(CommonReference.ui.choice_handler, [], "transition_in", "completed")
				parallel.run_all()
				await parallel.completed
				CommonReference.ui.text_handler.display_text(flavor_idle_comp[randi() % len(flavor_idle_comp)], TextHandler.TextSpeed.FAST, false)
				# Prevent nested recursion
				call_deferred("act")

func enter(before: State = null, data: Dictionary = {}) -> void:
	super.enter(before, data)
	CommonReference.ui.idle_sound_effect_player.play_sound()
	CommonReference.ui.choice_handler.initialize(["Skill", "Tactic", "Party", "Option"])
	
	var parallel: ParallelCoroutine = ParallelCoroutine.new()
	parallel.append(CommonReference.ui.text_handler, [], "transition_in", "completed")
	parallel.append(CommonReference.ui.choice_handler, [], "transition_in", "completed")
	parallel.run_all()
	await parallel.completed
	CommonReference.ui.text_handler.display_text("> Your COMP whirred to life.", TextHandler.TextSpeed.FAST, false)

func exit(after: State = null, data: Dictionary = {}) -> void:
	super.exit(after, data)
	CommonReference.ui.idle_sound_effect_player.stop_all()
	await CommonReference.ui.choice_handler.transition_out()
	await CommonReference.ui.text_handler.transition_out()
	

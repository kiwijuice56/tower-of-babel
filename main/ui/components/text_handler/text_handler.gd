class_name TextHandler
extends PanelContainer
# Handles all displays of dialogue and text

const INITIAL_HEIGHT: int = 14
const FINAL_HEIGHT: int = 28

enum TextSpeed {
	FAST = 3,
	MEDIUM = 2,
	SLOW = 1,
}

@export var transition_time: float = 0.04
@export var speed_up: float = 3.0

var seconds_per_character: float = 0.02
var speed_up_enabled: bool = false

signal completed
signal accepted
signal text_displayed

func _ready() -> void:
	%Timer.timeout.connect(_on_character_timeout)
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("a", false):
		accepted.emit()

func _on_character_timeout() -> void:
	if %Label.visible_characters == len(%Label.text):
		text_displayed.emit()
		return
	
	%Label.visible_characters += 1
	if speed_up_enabled and Input.is_action_pressed("left_shoulder"):
		%Timer.start(seconds_per_character * (1.0 / speed_up))
	else:
		%Timer.start(seconds_per_character)

func display_text(text: String, speed: int, accepting_input: bool) -> void:
	%Timer.stop()
	self.seconds_per_character = 0.03 / speed
	speed_up_enabled = accepting_input
	if accepting_input and is_instance_valid(CommonReference.ui):
		CommonReference.ui.input_help.append_instructions({"left_shoulder" : "fast"})
	
	%Label.text = text
	%Label.visible_characters = 0
	%Timer.start(seconds_per_character)
	await text_displayed
	
	if accepting_input:
		if is_instance_valid(CommonReference.ui):
			CommonReference.ui.input_help.append_instructions({"a" : "next"})
		
		set_process_input(true)
		%ContinueIcon.visible = true
		%ContinueIcon.texture.current_frame = 0 # Forces the flicker to be synced
		await accepted
		if is_instance_valid(CommonReference.ui):
			CommonReference.ui.input_help.remove_instructions({"left_shoulder" : "fast"})
			CommonReference.ui.input_help.remove_instructions({"a" : "next"})
		set_process_input(false)
		%ContinueIcon.visible = false

func clear() -> void:
	%Label.visible_characters = 0

func transition_in() -> void:
	%Timer.stop()
	
	%Label.visible_characters = 0
	%Label.custom_minimum_size.y = INITIAL_HEIGHT
	
	visible = true
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(%Label, "custom_minimum_size:y", FINAL_HEIGHT, transition_time)
	await tween.finished
	
	completed.emit()

func transition_out() -> void:
	%Timer.stop()
	
	%Label.custom_minimum_size.y = FINAL_HEIGHT
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(%Label, "custom_minimum_size:y", INITIAL_HEIGHT, transition_time)
	await tween.finished
	visible = false
	%Label.visible_characters = 0
	
	completed.emit()

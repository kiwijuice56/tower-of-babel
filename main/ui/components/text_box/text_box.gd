class_name TextBox
extends PanelContainer
# Handles all displays of dialogue and text

@export var seconds_per_character: float = 0.03
@export var speed_up: float = 3.0
@export var after_delay: float = 0.5

var speed_up_enabled: bool = false

signal accepted
signal text_displayed

func _ready() -> void:
	%Timer.timeout.connect(_on_character_timeout)
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("a", false):
		accepted.emit()

func display_text(text: String, accepting_input: bool) -> void:
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
		
		
	else:
		%Timer.start(after_delay)
		await %Timer.timeout
	
	%Label.text = ""

func _on_character_timeout() -> void:
	if %Label.visible_characters == len(%Label.text):
		text_displayed.emit()
		return
	
	%Label.visible_characters += 1
	if speed_up_enabled and Input.is_action_pressed("left_shoulder"):
		%Timer.start(seconds_per_character * (1.0 / speed_up))
	else:
		%Timer.start(seconds_per_character)

class_name UI
extends Node

# References to commonly used components for easy external access
# Other nodes could technically use the % symbol, but this allows me to debug with
# setget (if needed) and also allows Godot to pick up type hints
@onready var input_help_handler: InputHelpHandler = %InputHelpHandler
@onready var text_handler: TextHandler = %TextHandler
@onready var action_handler: ActionHandler = %ActionHandler
@onready var choice_handler: ChoiceHandler = %ChoiceHandler
@onready var encounter_radar_handler: EncounterRadarHandler = %EncounterRadarHandler

@onready var idle_sound_effect_player: SoundEffectPlayer = %IdleSoundEffectPlayer

class_name SoundEffectPlayer
extends Node

@export var stream: Resource
@export var volume_db: float = 0.0
@export var gradual_time: float = 0.1
@export var random_offset: bool = false

signal stopped

var existing_audio: Array[AudioStreamPlayer] = []

func play_sound() -> void:
	var audio: AudioStreamPlayer = _create_audio_player()
	audio.stream = stream
	
	add_child(audio)
	audio.play(audio.stream.get_length() * randf() if random_offset else 0.0)
	gradual_play(audio)

func _create_audio_player() -> AudioStreamPlayer:
	var audio: AudioStreamPlayer = AudioStreamPlayer.new()
	audio.volume_db = volume_db + GlobalSettings.sound_effect_volume
	existing_audio.append(audio)
	
	return audio

func stop_all() -> void:
	var to_stop: Array[AudioStreamPlayer] = existing_audio.duplicate()
	existing_audio.clear()
	for audio in to_stop:
		gradual_stop(audio)

func gradual_play(audio: AudioStreamPlayer) -> void:
	var target_volume: float = audio.volume_db
	audio.volume_db = -40.0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(audio, "volume_db", target_volume, gradual_time)

func gradual_stop(audio: AudioStreamPlayer) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(audio, "volume_db", -40.0, gradual_time)
	await tween.finished
	audio.queue_free()

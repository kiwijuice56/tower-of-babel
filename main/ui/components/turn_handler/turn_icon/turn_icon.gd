class_name TurnIcon
extends TextureRect

const FINAL_WIDTH: int = 12

@export var scale_time: float = 0.05

var is_flashing: bool = false

signal completed

func _ready() -> void:
	custom_minimum_size.x = 0

func transition_in() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "custom_minimum_size:x", FINAL_WIDTH, scale_time)
	await tween.finished
	
	%AnimationPlayer.play("add")
	await %AnimationPlayer.animation_finished
	
	completed.emit()

func transition_out() -> void:
	%AnimationPlayer.play("remove")
	await %AnimationPlayer.animation_finished
	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "custom_minimum_size:x", 0, scale_time)
	await tween.finished
	
	completed.emit()

func flash() -> void:
	is_flashing = true
	%AnimationPlayer.play("start_flash")
	await %AnimationPlayer.animation_finished
	%AnimationPlayer.play("flash")
	completed.emit()

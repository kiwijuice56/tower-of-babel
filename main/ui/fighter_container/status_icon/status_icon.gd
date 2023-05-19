class_name StatusIcon
extends TextureRect

const SPRITE_PATH = "res://main/ui/fighter_container/status_icon/sprites/"

const SPRITES: Dictionary = {
	StatusEffect.BLEED : preload(SPRITE_PATH + "bleed.png"),
	StatusEffect.DEAD : preload(SPRITE_PATH + "dead.png"),
	StatusEffect.RADIATION : preload(SPRITE_PATH + "radiation_poison.png"),
	StatusEffect.DRUGGED : preload(SPRITE_PATH + "drugged.png")
}
var effects: Array[int]

func _ready() -> void:
	texture = null
	%Timer.timeout.connect(_on_swap_timeout)
	
	# TESTING
	if randf() < 0.4: add_status_effect(StatusEffect.RADIATION)
	if randf() < 0.4: add_status_effect(StatusEffect.DRUGGED)
	if randf() < 0.5: add_status_effect(StatusEffect.BLEED)

func _on_swap_timeout() -> void:
	if effects.is_empty():
		texture = null
	else:
		effects.append(effects.pop_front())
		texture = SPRITES[effects.front()]

func add_status_effect(status: int) -> void:
	effects.insert(0, status)
	_on_swap_timeout()
	%Timer.start()

func remove_status_effect(status: int) -> void:
	if effects.find(status) == -1:
		return
	effects.remove_at(effects.find(status))

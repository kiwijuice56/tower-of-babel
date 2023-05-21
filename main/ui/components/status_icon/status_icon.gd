class_name StatusIcon
extends TextureRect
# Displays the status effects inflicted on a Fighter

const SPRITE_PATH = "res://main/ui/components/status_icon/sprites/"
const SPRITES: Dictionary = {
	Fighter.StatusEffect.BLEED: preload(SPRITE_PATH + "bleed.png"),
	Fighter.StatusEffect.DEAD: preload(SPRITE_PATH + "dead.png"),
	Fighter.StatusEffect.RADIATION: preload(SPRITE_PATH + "radiation_poison.png"),
	Fighter.StatusEffect.DRUGGED: preload(SPRITE_PATH + "drugged.png")
}
var status_effects: Array[int]

func _ready() -> void:
	texture = null
	%Timer.timeout.connect(_on_swap_timeout)

func _on_swap_timeout() -> void:
	if status_effects.is_empty():
		texture = null
	else:
		status_effects.append(status_effects.pop_front())
		texture = SPRITES[status_effects.front()]

func set_status_effects(status_effects: Array[int]) -> void:
	self.status_effects = status_effects.duplicate()
	_on_swap_timeout()
	%Timer.start()

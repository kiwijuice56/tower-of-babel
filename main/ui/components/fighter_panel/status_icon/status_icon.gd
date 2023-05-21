class_name StatusIcon
extends TextureRect
# Cycles through status effect sprites on a FighterPanel

const SPRITE_PATH = "res://main/ui/components/fighter_panel/status_icon/sprites/"

const SPRITES: Dictionary = {
	Fighter.StatusEffect.BLEED : preload(SPRITE_PATH + "bleed.png"),
	Fighter.StatusEffect.DEAD : preload(SPRITE_PATH + "dead.png"),
	Fighter.StatusEffect.RADIATION : preload(SPRITE_PATH + "radiation_poison.png"),
	Fighter.StatusEffect.DRUGGED : preload(SPRITE_PATH + "drugged.png")
}
var effects: Array[int]

func _ready() -> void:
	texture = null
	%Timer.timeout.connect(_on_swap_timeout)

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

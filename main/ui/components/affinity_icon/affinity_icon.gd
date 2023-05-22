class_name AffinityIcon
extends TextureRect
# Displays an icon for each element

const SPRITE_PATH = "res://main/ui/components/affinity_icon/sprites/"
const SPRITES: Dictionary = {
	Action.Element.NONE: preload(SPRITE_PATH + "element1.png"),
	Action.Element.PHYSICAL: preload(SPRITE_PATH + "element2.png"),
	Action.Element.FIRE: preload(SPRITE_PATH + "element3.png"),
	Action.Element.ICE: preload(SPRITE_PATH + "element4.png"),
	Action.Element.ELECTRICITY: preload(SPRITE_PATH + "element5.png"),
	Action.Element.EARTH: preload(SPRITE_PATH + "element6.png"),
	Action.Element.CELESTIAL: preload(SPRITE_PATH + "element7.png"),
	Action.Element.HEALING: preload(SPRITE_PATH + "element8.png"),
	Action.Element.SUPPORT: preload(SPRITE_PATH + "element9.png"),
	Action.Element.ALMIGHTY: preload(SPRITE_PATH + "element10.png"),
}

func _ready() -> void:
	initialize(randi() % (len(Action.Element) - 1))

func initialize(element: int) -> void:
	texture = SPRITES[int(pow(2, element))] 

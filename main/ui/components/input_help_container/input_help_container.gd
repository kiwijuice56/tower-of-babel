class_name InputHelpContainer
extends PanelContainer
# Displays possible actions and their associated keys/buttons at the bottom of the screen

# Generally, components themselves should not access this node in order to prevent glitchy
# transitions

const SPRITES: Dictionary = {
	"left_right": preload("res://main/ui/components/input_help_container/sprites/left_right_arrows.png"),
	"up_down": preload("res://main/ui/components/input_help_container/sprites/up_down_arrows.png")
}

@export var key_color: Color
@export var action_color: Color

var all_input: Dictionary

func append_instructions(input: Dictionary) -> void:
	all_input.merge(input)
	update_text() 

func remove_instructions(input: Dictionary) -> void:
	for action in input:
		all_input.erase(action)
	update_text() 

func update_text() -> void:
	clear()
	
	for action in all_input:
		var label: RichTextLabel = RichTextLabel.new()
		label.fit_content = true
		label.autowrap_mode = TextServer.AUTOWRAP_OFF
		
		if action in SPRITES:
			var rect: TextureRect = TextureRect.new()
			rect.stretch_mode = TextureRect.STRETCH_KEEP
			rect.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			rect.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
			rect.texture = SPRITES[action]
			%LabelContainer.add_child(rect)
		else:
			var primary_event: InputEvent = InputMap.action_get_events(action)[0]
			label.append_text(TextColor.get_colored_text("-" + primary_event.as_text().substr(0, 1), key_color))
		label.append_text(TextColor.get_colored_text(" " + all_input[action] + " ", action_color))
		%LabelContainer.add_child(label)

func clear() -> void:
	for child in %LabelContainer.get_children():
		%LabelContainer.remove_child(child)
		child.queue_free()

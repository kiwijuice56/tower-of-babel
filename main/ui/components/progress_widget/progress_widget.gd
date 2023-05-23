class_name ProgressWidget
extends HBoxContainer
# Displays a progress bar with text, especially for HP and SP

@export var label: String
@export var high_color: Color 
@export var low_color: Color
@export var segments: int = 4

func _ready() -> void:
	set_number(100)
	set_progress(0.5)

func initialize(n: int, p: float) -> void:
	set_number(n)
	set_progress(p)

func set_number(n: int) -> void:
	%Number.add_theme_color_override("font_color", high_color)
	%Number.text = str(n)

func set_progress(p: float) -> void:
	p = clampf(p, 0.0, 1.0)
	high_color.srgb_to_linear()
	
	$Bar.clear()
	$Bar.append_text(TextColor.get_colored_text("[", high_color))
	
	for i in range(segments):
		var lower_bound: float = 1.0 / segments * i
		var upper_bound: float = 1.0 / segments * (i + 1)
		
		if p >= lower_bound and p < upper_bound:
			var x: float = (p - lower_bound) / (upper_bound - lower_bound)
			$Bar.append_text(TextColor.get_colored_text(label if i == 0 else "#", low_color.lerp(high_color, x)))
		elif p < lower_bound:
			$Bar.append_text(TextColor.get_colored_text("-", low_color))
		else:
			$Bar.append_text(TextColor.get_colored_text(label if i == 0 else "#", high_color))
	
	$Bar.append_text(TextColor.get_colored_text("]", high_color))

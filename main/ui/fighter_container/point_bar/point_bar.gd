class_name PointBar
extends HBoxContainer

@export var label: String
@export var high_color: Color 
@export var low_color: Color
@export var segments: int = 4

# TESTING
var debug: float = 0.0
func _process(delta: float) -> void:
	debug += delta
	set_number(int(400 * (sin(debug) / 2.0 + 0.5)))
	set_progress(sin(debug) / 2.0 + 0.5)

func set_number(n: int) -> void:
	%Number.add_theme_color_override("font_color", high_color)
	%Number.text = str(n)

func set_progress(p: float) -> void:
	p = clampf(p, 0.0, 1.0)
	high_color.srgb_to_linear()
	
	$Bar.clear()
	add_colored_string("[", high_color)
	
	for i in range(segments):
		var lower_bound: float = 1.0 / segments * i
		var upper_bound: float = 1.0 / segments * (i + 1)
		
		if p > lower_bound and p < upper_bound:
			var x: float = (p - lower_bound) / (upper_bound - lower_bound)
			add_colored_string(label if i == 0 else "#", low_color.lerp(high_color, x))
		elif p <= lower_bound:
			add_colored_string("-", low_color)
		else:
			add_colored_string(label if i == 0 else "#", high_color)
	
	add_colored_string("]", high_color)

func add_colored_string(s: String, color: Color) -> void:
	%Bar.append_text("[color=" + color.to_html(false) + "]" + s + "[/color]")

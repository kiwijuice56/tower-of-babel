class_name StatusWidget
extends TextureRect
# Displays the status effects inflicted on a Fighter

var status_effects: Array[Status]

func _ready() -> void:
	texture = null
	%Timer.timeout.connect(_on_swap_timeout)

func _on_swap_timeout() -> void:
	if status_effects.is_empty():
		texture = null
	else:
		status_effects.append(status_effects.pop_front())
		texture = status_effects.front().icon

func set_status_effects(status_effects: Array[Status]) -> void:
	self.status_effects = status_effects.duplicate()
	_on_swap_timeout()
	%Timer.start()

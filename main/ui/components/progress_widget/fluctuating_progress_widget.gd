class_name FluctuatingProgressWidget
extends ProgressWidget

@export var fluctuate_speed: float = 6.0
@export var fluctuate_max: float = 0.03

var offset: float = 0
var progress: float = 0
var number: float = 0

func _process(delta: float) -> void:
	offset += delta * fluctuate_speed
	var fluctuation: float = (sin(offset * 1.231850) + sin(offset * 1.1239120) + cos(offset * 1.3901293)) * fluctuate_max
	
	super.set_progress(progress + fluctuation)
	super.set_number(int(number + 100 * fluctuation))

func set_progress(p: float) -> void:
	self.progress = p

func set_number(n: int) -> void:
	self.number = n

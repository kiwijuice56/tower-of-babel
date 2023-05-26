class_name RandomEncounter
extends Encounter
# Randomly selects enemies from a given pool with weighted probabilites 

@export var possible_enemies: Array[Fighter]
@export var cumulative_weights: Array[float]
@export var count_min: int
@export var count_max: int

func get_enemies() -> Array[Fighter]:
	var count: int = randi_range(count_min, count_max)
	var enemies: Array[Fighter] = []
	
	for enemy in count:
		var rand: float = randf()
		for i in range(len(possible_enemies)):
			if rand < cumulative_weights[i]:
				enemies.append(enemy)
				break
	
	return enemies

class_name Player
extends Node3D

@export var move_speed: float = 0.3
@export var turn_speed: float = 0.4

var tween: Tween

var dir: Vector3 = Vector3(0, 0, -1)

func _physics_process(delta: float):
	if tween != null and tween.is_running():
		return
	
	var new_dir: Vector3 = dir
	if Input.is_action_pressed("left"):
		new_dir = dir.rotated(Vector3(0, 1, 0), PI/2)
		var angle: float = rad_to_deg(dir.angle_to(new_dir))
		tween = get_tree().create_tween()
		tween.tween_property(%CameraPivot, "rotation_degrees", Vector3(0, %CameraPivot.rotation_degrees.y + angle, 0), turn_speed)
		dir = new_dir
		return
	
	if Input.is_action_pressed("right"):
		new_dir = -dir.rotated(Vector3(0,1,0), PI/2)
		var angle = -rad_to_deg(dir.angle_to(new_dir))
		tween = get_tree().create_tween()
		tween.tween_property(%CameraPivot, "rotation_degrees", Vector3(0, %CameraPivot.rotation_degrees.y + angle, 0), turn_speed)
		dir = new_dir
		return
	
	if Input.is_action_pressed("up"):
		%CollisionCheck.force_raycast_update()
		if not %CollisionCheck.is_colliding(): 
			tween = get_tree().create_tween()
			tween.tween_property(self, "position", position + dir, move_speed)
			return

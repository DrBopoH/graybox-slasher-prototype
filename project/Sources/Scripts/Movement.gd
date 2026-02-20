extends KinematicBody

export(float) var gravity = -9.8

var velocity: Vector3

func _physics_process(delta):
	var direction = Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_select") - Input.get_action_strength("ui_focus"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	var target = get_parent().get_global_direction2d(direction)*3
	
	velocity.x = move_toward(velocity.x, target.x, delta*66)
	velocity.z = move_toward(velocity.z, target.z, delta*66)
	
	if Vector2(velocity.x, velocity.z).length_squared() > 0.01:
		var target_rotation = atan2(velocity.x, velocity.z)
		rotation.y = lerp_angle(rotation.y, target_rotation, delta * 15.0)
	
	if is_on_floor():
		velocity.y = -0.1 
	else:
		velocity.y += gravity*delta
	
	velocity = move_and_slide(velocity, Vector3.UP, true)

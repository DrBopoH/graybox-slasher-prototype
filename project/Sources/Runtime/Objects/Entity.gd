class_name Entity
extends KinematicBody

export(float) var gravity_force = -9.8
export(float) var jump_force = 4.3
export(float) var move_speed = 2.5
export(float, 0.01, 100.0) var stoping_sharpness = 66.666
export(float, 0.01, 100.0) var rotation_sharpness = 16.666

var prepared_velocity: Vector3
var velocity: Vector3

func _physics_process(delta):
	if is_on_floor():
		velocity.x = move_toward(velocity.x, prepared_velocity.x*move_speed, stoping_sharpness*delta)
		velocity.z = move_toward(velocity.z, prepared_velocity.z*move_speed, stoping_sharpness*delta)
		if prepared_velocity.y > 0:
			velocity.y += prepared_velocity.y*jump_force
	else:
		velocity.y += gravity_force*delta
	
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	if Vector2(velocity.x, velocity.z).length_squared() > 0.01:
		var target_rotation = atan2(velocity.x, velocity.z)
		rotation.y = lerp_angle(rotation.y, target_rotation, rotation_sharpness*delta)

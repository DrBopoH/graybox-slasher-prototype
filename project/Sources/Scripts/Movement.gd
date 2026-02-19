extends KinematicBody

export(float) var gravity = -9.8

var velocity: Vector3

var camera := Camera.new()
var camera_gimbal := Spatial.new()
var inner_gimbal := Spatial.new()
var spring_arm := SpringArm.new()

func _ready():
	camera.translation.z = 3
	camera.current = true
	
	spring_arm.margin = 0.5
	spring_arm.spring_length = 3
	
	spring_arm.add_child(camera)
	inner_gimbal.add_child(spring_arm)
	camera_gimbal.add_child(inner_gimbal)
	add_child(camera_gimbal)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func mouse_toggle_capture():
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_global_direction(local_direction: Vector3) -> Vector3:
	return camera_gimbal.global_transform.basis * local_direction

func get_global_direction2d(local_direction: Vector3) -> Vector3:
	return camera_gimbal.global_transform.basis.x * local_direction.x + camera_gimbal.global_transform.basis.z * local_direction.z

func camera_rotate(relative: Vector2):
	camera_gimbal.rotate_y(deg2rad(-relative.x))
	inner_gimbal.rotate_x(deg2rad(-relative.y))

func clamp_camera_x_rotation():
	var cam_rotation = inner_gimbal.rotation_degrees
	cam_rotation.x = clamp(cam_rotation.x, -60, 45)
	inner_gimbal.rotation_degrees = cam_rotation

func camera_shapemove_rotate(relative: Vector2):
	camera_rotate(relative)
	clamp_camera_x_rotation()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera_shapemove_rotate(event.relative)
	
	if event is InputEventKey and event.scancode == KEY_ALT:
		if event.is_pressed(): 
			mouse_toggle_capture()

func _physics_process(delta):
	var direction = Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_select") - Input.get_action_strength("ui_focus"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	var target = get_global_direction2d(direction)*10
	
	velocity.x = move_toward(velocity.x, target.x, delta*66)
	velocity.z = move_toward(velocity.z, target.z, delta*66)
	
	#if Vector2(velocity.x, velocity.z).length_squared() > 0.01:
	#	var target_rotation = atan2(velocity.x, velocity.z)
	#	rotation.y = lerp_angle(rotation.y, target_rotation, delta * 15.0)

	
	if is_on_floor():
		velocity.y = -0.1 
	else:
		velocity.y += gravity*delta
	
	velocity = move_and_slide(velocity, Vector3.UP, true)

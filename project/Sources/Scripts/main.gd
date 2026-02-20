extends Node

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

func _process(delta):
	camera_gimbal.translation = $Player.translation

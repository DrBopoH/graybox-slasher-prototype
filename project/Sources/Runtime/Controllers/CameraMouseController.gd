class_name CameraMouseController
extends KinematicBody

export(Resource) var ControllerTres

var prepared_velocity: Vector3

var camera: Camera
var entity: Entity

var last_one: Spatial
var inner_gimbal: Spatial

func add_camera(object: Camera): 
	camera = object
	last_one.add_child(camera)

func remove_camera(): 
	last_one.remove_child(camera)
	camera = null

func link_entity(object: KinematicBody): entity = object
func unlink_entity(): entity = null


func _ready(): Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		CameraMath.rotate(event.relative, self, inner_gimbal)
		CameraMath.clamp_x_rotation(inner_gimbal, ControllerTres.clamp_min_x_rotation, ControllerTres.clamp_max_x_rotation)
	
	if event is InputEventKey and event.scancode == KEY_ALT:
		if event.is_pressed(): MouseControl.toggle_capture()

func _process(delta):
	if entity:
		translation = entity.translation
	else:
		move_and_slide(prepared_velocity, Vector3.UP)

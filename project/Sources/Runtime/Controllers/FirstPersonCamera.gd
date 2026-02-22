class_name FirstPersonCamera
extends CameraMouseController

func _init():
	name = "FirstPersonCamera"
	
	inner_gimbal = Spatial.new()
	inner_gimbal.name = "Inner Gimbal"
	
	last_one = inner_gimbal

func _ready():
	ControllerTres = load("res://Assets/Data/Camera/FirstPersonCamera.tres")
	
	self.add_child(inner_gimbal)

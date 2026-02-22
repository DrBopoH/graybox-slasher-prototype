class_name ThirdPersonCamera
extends CameraMouseController

var spring_arm: SpringArm

func _init():
	name = "ThirdPersonCamera"
	
	spring_arm = SpringArm.new()
	spring_arm.name = "spring arm"
	spring_arm.margin = 0.5
	spring_arm.spring_length = 3
	
	inner_gimbal = Spatial.new()
	inner_gimbal.name = "inner gimbal"
	
	last_one = spring_arm

func _ready():
	ControllerTres = load("res://Assets/Data/Camera/ThirdPersonCamera.tres")
	
	inner_gimbal.add_child(spring_arm)
	self.add_child(inner_gimbal)

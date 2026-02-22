extends Node

enum CameraModes {FollowEntity, FreeFlying}
enum ViewModes {FirstPerson, ThirdPerson}

export(ViewModes) var viewmode
export(CameraModes) var cameramode

export(NodePath) var player_path
export(NodePath) var camera_path

var player: KinematicBody
var camera: Camera

var CameraController: CameraMouseController

var PlayerController := CharacterController.new()

func _ready():
	player = get_node(player_path)
	
	camera = get_node(camera_path)
	self.remove_child(camera)
	
	match viewmode:
		ViewModes.FirstPerson: CameraController = FirstPersonCamera.new()
		ViewModes.ThirdPerson: CameraController = ThirdPersonCamera.new()
	
	self.add_child(CameraController)
	CameraController.add_camera(camera)
	
	match cameramode:
		CameraModes.FollowEntity:
			CameraController.link_entity(player)
			PlayerController.link_entity(player)
		CameraModes.FreeFlying:
			PlayerController.link_entity(CameraController)

func _input(event):
	PlayerController.handle_input(camera)

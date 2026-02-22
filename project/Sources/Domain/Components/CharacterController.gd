class_name CharacterController
extends Reference

var entity: KinematicBody

func link_entity(object: KinematicBody): entity = object
func unlink_entity(): entity = null

func handle_input(camera: Camera):
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	)
	
	entity.prepared_velocity = CameraMath.get_global_direction_from2d(direction, camera).normalized()
	entity.prepared_velocity.y = Input.get_action_strength("jump") - Input.get_action_strength("dodge")

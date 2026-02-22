class_name StateMachine
extends Reference

enum States {
	MOVE,
	AIR,
	DODGE,
	ATTAK
}

export(States) var state = States.MOVE

func update(delta):
	match state:
		States.MOVE:
			state_move(delta)
		States.AIR:
			state_air(delta)
		States.DODGE:
			state_dodge(delta)
		States.ATTAK:
			state_attack(delta)

func state_move(delta: float):
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	)
	
	#var target := CameraControl.get_global_direction_from2d(direction, )

func state_air(delta: float):
	pass

func state_dodge(delta: float):
	pass

func state_attack(delta: float):
	pass

class_name CameraMath
extends Reference

static func get_global_direction(local_direction: Vector3, object: Spatial) -> Vector3:
	return object.global_transform.basis * local_direction

static func get_global_direction_from2d(local_direction: Vector2, object: Spatial) -> Vector3:
	return object.global_transform.basis.x * local_direction.x + object.global_transform.basis.z * local_direction.y

static func rotate(relative: Vector2, object_gimbal: Spatial, inner_gimbal: Spatial):
	object_gimbal.rotate_y(deg2rad(-relative.x))
	inner_gimbal.rotate_x(deg2rad(-relative.y))

static func clamp_x_rotation(inner_gimbal: Spatial, minimal_degrees: float = -90, maximal_degrees: float = 90):
	var cam_rotation = inner_gimbal.rotation_degrees
	cam_rotation.x = clamp(cam_rotation.x, minimal_degrees, maximal_degrees)
	inner_gimbal.rotation_degrees = cam_rotation

static func shapemove_rotate(relative: Vector2, object_gimbal: Spatial, inner_gimbal: Spatial):
	rotate(relative, object_gimbal, inner_gimbal)
	clamp_x_rotation(inner_gimbal)

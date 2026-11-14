extends RigidBody2D

@export var speed := 100
func _physics_process(delta: float) -> void:
	var mouse_pos := get_local_mouse_position()
	var mouse_dir := position.direction_to(mouse_pos)
	apply_force(mouse_dir)

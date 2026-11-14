extends CharacterBody2D


var mousedistance 
var direction
#const JUMP_VELOCITY = -400.0

func _ready() -> void:
	position = Vector2(0,0)
	velocity = Vector2(0,0)
	print(velocity)
func _physics_process(delta: float) -> void:
	# Add the gravity.
#	if not is_on_floor():
	mousedistance = get_viewport().get_mouse_position().distance_to(get_viewport().get_visible_rect().size/2)/15
	direction = (get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size/2).normalized()
	#if velocity >= Vector2(-1000,-1000) or velocity <= Vector2(1000,1000): #uncontrollable
	velocity += direction * mousedistance 
	var collision = move_and_collide(velocity*delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
		var newvel = velocity.length()*direction*1.05
		if newvel.length_squared() < 1000000000:
			print(newvel)
			velocity = newvel
		

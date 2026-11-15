extends RigidBody2D

var mousedistance 
var direction
var velocity
var bouncebuffer
#const JUMP_VELOCITY = -400.0

func _ready() -> void:
	position = Vector2(0,0)
	velocity = Vector2(0,0)
	bouncebuffer = 0
	print(velocity)
func _physics_process(delta: float) -> void:
	# Add the gravity.
#	if not is_on_floor():
	mousedistance = get_viewport().get_mouse_position().distance_to(get_viewport().get_visible_rect().size/2)/5
	direction = (get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size/2).normalized()
	#print(direction)
	#if velocity >= Vector2(-1000,-1000) or velocity <= Vector2(1000,1000): #uncontrollable
	velocity += direction * mousedistance*delta
	#apply_force(velocity*delta)
	#move_and_collide(velocity*delta)
	var collision = move_and_collide(velocity*delta)
	#bouncebuffer  = max(bouncebuffer - 1,0)
	#print(velocity)
	if collision: #and bouncebuffer == 0:
		direction = direction.bounce(collision.get_normal()).normalized()
		#print(direction)
		var newvel = velocity.length()*direction*1.25
		position += newvel*0.01
		if true:#newvel >= Vector2(-1500,-1500) and newvel <= Vector2(1500,1500):
			#print(velocity)
			velocity = newvel#.clamp(Vector2(-1500,-1500),Vector2(1500,1500))
		else:
			velocity =(velocity.length()*direction)#.clamp(Vector2(-1000,-1000),Vector2(1000,1000))
		#bouncebuffer = 10
	if velocity <= Vector2(-1500,-1500) or velocity >= Vector2(1500,1500):
		velocity = velocity * 0.9
			#apply_force(newvel*delta)

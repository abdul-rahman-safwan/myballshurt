extends CharacterBody2D

#@export var tilemap: TileMapLayer

var mousedistance 
var direction
var bouncebuffer

signal hit(hitpos)
@export var map: TileMapLayer

var explosion = preload("res://Scenes/explosion.tscn")
#const JUMP_VELOCITY = -400.0

func _ready() -> void:
	position = Vector2(0,0)
	velocity = Vector2(0,0)
	bouncebuffer = 0
func _physics_process(delta: float) -> void:
	# Add the gravity.
#	if not is_on_floor():
	mousedistance = get_viewport().get_mouse_position().distance_to(get_viewport().get_visible_rect().size/2)
	direction = (get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size/2).normalized()
	#print(direction)
	#if velocity >= Vector2(-1000,-1000) or velocity <= Vector2(1000,1000): #uncontrollable
	velocity += direction * mousedistance*delta
	#apply_force(velocity*delta)
	#move_and_collide(velocity*delta)
	var collision = move_and_collide(velocity*delta)
	bouncebuffer  = max(bouncebuffer - 1,0)
	if collision and bouncebuffer == 0:
		#print(collision)
		direction = direction.bounce(collision.get_normal()).normalized()
		#print(direction)
		var newvel = velocity.length()*direction*1.45
		position += newvel*0.01
	#	print(velocity.length_squared()**0.4)
		if true:#newvel >= Vector2(-1500,-1500) and newvel <= Vector2(1500,1500):
			#print(velocity)
			velocity = newvel#.clamp(Vector2(-1500,-1500),Vector2(1500,1500))
		else:
			velocity =(velocity.length()*direction)#.clamp(Vector2(-1000,-1000),Vector2(1000,1000))
		bouncebuffer = 5
		var explode = explosion.instantiate()
		explode.map = map
		get_parent().add_child(explode)
		var explosion_size = (velocity.length_squared() ** 0.3)/128
		explode.scale = explode.scale*  explosion_size
		explode.position = collision.get_position()
		#emit_signal("hit",collision.get_position() )
	if velocity <= Vector2(-2000,-2000) or velocity >= Vector2(2000,2000):
		velocity = velocity * 0.9
			#apply_force(newvel*delta)
		

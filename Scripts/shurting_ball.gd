extends CharacterBody2D

#@export var tilemap: TileMapLayer

var mousedistance 
var direction
var bouncebuffer
var glob = Global

var explosionsizemult = 0.8
var explosCost = 50
var ballsize = 1
var ballCost = 60
var acceleration = 1.2#1.45#1.2
var accelCost = 75
var maxSpeed = 800
var speedCost = 40
var mousepower = 1.5
var mouseCost = 25
var mouseredirectiontimer = 100

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
	$"../CanvasLayer/MoneyCount".text = str("Total money : ", glob.money)
	mousedistance = get_viewport().get_mouse_position().distance_to(get_viewport().get_visible_rect().size/2)
	direction = (get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size/2).normalized()
	#print(direction)
	#if velocity >= Vector2(-1000,-1000) or velocity <= Vector2(1000,1000): #uncontrollable
	velocity += direction * mousedistance*delta#*mousepower
	#apply_force(velocity*delta)
	#move_and_collide(velocity*delta)
	var collision = move_and_collide(velocity*delta)
	bouncebuffer  = max(bouncebuffer - 1,0)
	if collision and bouncebuffer == 0:
		#print(collision)
		direction = direction.bounce(collision.get_normal()).normalized()
		#print(direction)
		var newvel = velocity.length()*direction*acceleration
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
		var explosion_size = (velocity.length_squared() ** 0.3)/128*explosionsizemult
		explode.scale = explode.scale*  explosion_size
		explode.position = collision.get_position()
		#emit_signal("hit",collision.get_position() )
	if velocity <= Vector2(-maxSpeed,-maxSpeed) or velocity >= Vector2(maxSpeed,maxSpeed):
		velocity = velocity * 0.9
			#apply_force(newvel*delta)
func _process(delta: float) -> void:
	print(mouseredirectiontimer/100)
	if Input.is_action_just_pressed("Click"):
		if mouseredirectiontimer <= 0:
			direction = (get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size/2).normalized()
			velocity = velocity.length()*direction*mousepower
			mouseredirectiontimer = 100
		else:
			print("wwait for timer bruh")
	elif Input.is_action_just_pressed("Upgrade Ball Size"):
		if glob.money >= ballCost:
			glob.money -= ballCost
			ballCost *= 2
			ballsize *= 1.15
			$"../CanvasLayer/BallCost".text = str("[D] Ball Size Upgrade Cost : ", ballCost)
			$".".scale = Vector2(ballsize,ballsize)
			$Camera2D.zoom = Vector2(1/ballsize,1/ballsize)
	elif Input.is_action_just_pressed("Upgrade Max Speed"):
		if glob.money >= speedCost:
			glob.money -= speedCost
			speedCost *= 2
			maxSpeed *= 1.25
			$"../CanvasLayer/SpeedCost".text = str("[S] Maximum Speed Upgrade Cost: ", speedCost)
	elif Input.is_action_just_pressed("Upgrade Acceleration"):
		if glob.money >= accelCost:
			glob.money -= accelCost
			accelCost *= 2
			acceleration +=0.1
			$"../CanvasLayer/AccelCost".text = str("[A] Bounce Acceleration Upgrade Cost : ", accelCost)
	elif Input.is_action_just_pressed("Upgrade Explosions"):
			if glob.money >= explosCost:
				glob.money -= explosCost
				explosCost *= 2
				explosionsizemult +=0.15
				$"../CanvasLayer/ExplosionCost".text = str("[F] Explosion Upgrade Cost : ", explosCost)
	elif Input.is_action_just_pressed("Upgrade Mousepower"):
		if glob.money >= mouseCost:
			glob.money -= mouseCost
			mouseCost *= 2
			mousepower *= 1.25
			$"../CanvasLayer/MouseCost".text = str("[E] Mouse Shurting Upgrade Cost : ", mouseCost)
	$"../CanvasLayer/ClickTimer/Sliding".scale.x = 1-(mouseredirectiontimer/100)
	mouseredirectiontimer = max(mouseredirectiontimer - 1,0)

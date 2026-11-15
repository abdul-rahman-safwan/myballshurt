extends Area2D

#@export var map: TileMapLayer
var map: TileMapLayer
var glob = Global
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("AnimatedSprite2D").play()
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print(map)
func _on_timer_timeout():
#	print("done")
	queue_free()

func _on_shurting_ball_hit(hitpos: Variant) -> void:
	pass # Replace with function body.


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
#	print(map)
	var color = map.get_cell_atlas_coords(map.get_coords_for_body_rid(body_rid))
	map.erase_cell(map.get_coords_for_body_rid(body_rid))
	if color == Vector2i(0,0):
		glob.money +=1
	elif color == Vector2i(1,0):
		glob.money +=2
	elif color == Vector2i(0,1):
		glob.money +=4
	elif color == Vector2i(1,1):
		glob.money +=8
	

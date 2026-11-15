extends Area2D

#@export var map: TileMapLayer
var map: TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("AnimatedSprite2D").play()
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout():
#	print("done")
	queue_free()

func _on_shurting_ball_hit(hitpos: Variant) -> void:
	pass # Replace with function body.


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
#	print(map)
	map.erase_cell(map.get_coords_for_body_rid(body_rid))
	pass # Replace with function body.

extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(tile_map_data)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_shurting_ball_hit(hitpos: Variant) -> void:
	print("it wokrs!!!!!", hitpos)
	var cellpos = local_to_map(hitpos)
	erase_cell(cellpos)
	pass # Replace with function body.

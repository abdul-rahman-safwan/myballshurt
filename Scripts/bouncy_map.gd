extends TileMapLayer

@export var noise_height_text : NoiseTexture2D
var noise : Noise

var noisearray = []
var width = 500
var height = 500

var sourceid = 0
var atlas = {
	"white" : Vector2(-1,-1),
	"red" :Vector2(0,0),
	"blue" :Vector2(1,0),
	"yellow" :Vector2(0,1),
	"green" :Vector2(1,1)
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise = noise_height_text.noise
	generate_world()
	#print(tile_map_data)
	pass # Replace with function body.

func generate_world():
	for x in range(width):
		for y in range(height):
			var noise_val = noise.get_noise_2d(x,y)
			#print(noise_val)
			if noise_val <= -0.4:
				$".".set_cell(Vector2(x-250,y-250), sourceid,atlas["white"])
			elif noise_val <= 0.2:
				#print("set to red")
				$".".set_cell(Vector2(x-250,y-250), sourceid,atlas["red"])
			elif noise_val <= 0.3:
				$".".set_cell(Vector2(x-250,y-250), sourceid,atlas["yellow"])
			elif noise_val <= 0.4:
				$".".set_cell(Vector2(x-250,y-250), sourceid,atlas["blue"])
			else:
				$".".set_cell(Vector2(x-250,y-250), sourceid,atlas["green"])
			#noisearray.append(noise_val)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.


##func _on_shurting_ball_hit(hitpos: Variant) -> void:
	#print("it wokrs!!!!!", hitpos)
	#var cellpos = local_to_map(hitpos)
	#erase_cell(cellpos)
	#pass # Replace with function body.

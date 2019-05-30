extends TileMap

enum TileType{
	VOID,
	GRASS,
	FOREST,
	WATER,
	RESIDENTIAL,
	COMMERCIAL,
	INDUSTRIAL,
	ROAD
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	
	file.open("res://Asset/city_map.dat", File.READ)
	
	for x in range(64):
		for y in range(64):
			set_cell(y, x, file.get_32()-1)
			file.get_32()
			file.get_32()
			file.get_32()
			file.get_64()
	
	file.close()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("mouse_left_button"):
		var v = world_to_map(get_global_mouse_position())
		print(v)
		set_cell(v.x, v.y, -1)
	pass

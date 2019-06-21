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

var mouseBool = false
var select_start:Vector2
var select_tmp:Vector2
var select_tmp_index:int

var array=PoolByteArray()

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	
	file.open("res://Asset/city_map.dat", File.READ)
	
	for x in range(64):
		for y in range(64):
			var c = file.get_32()-1
			array.append(c)
			set_cell(y, x, c)
			file.get_32()
			file.get_32()
			file.get_32()
			file.get_64()
	
	file.close()

	pass # Replace with function body.

func activeSelect():
	var v = world_to_map(get_global_mouse_position())

	v.x = clamp(v.x, 0, 63)
	v.y = clamp(v.y, 0, 63)

	if v != select_tmp:
		set_cell(select_tmp.x, select_tmp.y, array[select_tmp.y*64+select_tmp.x])
		set_cell(v.x, v.y, 3)
		select_tmp=v

func get_pos_selected_cell():
	return Helper.vector2_clamp( world_to_map( get_global_mouse_position() ), 0, 63 )

func get_array_cell(x, y):
	return array[y*64+x]

func reset_cell(x, y):
	set_cell(x, y, get_array_cell(x, y) )

func reset_selected_cells(pos_ori, pos_fina):
	var diff_x = abs(pos_fina.x-pos_ori.x)
	var diff_y = abs(pos_fina.y-pos_ori.y)
	
	if pos_fina.x < pos_ori.x:
		pos_fina.x+=diff_x
		pos_ori.x-=diff_x
		
	if pos_fina.y < pos_ori.y:
		pos_fina.y+=diff_y
		pos_ori.y-=diff_y

	if diff_y == 0 and diff_x>0:
		for i in range(diff_x+1):
			reset_cell(pos_ori.x+i, pos_ori.y)
	elif diff_x == 0:
		for j in range(diff_y+1):
			reset_cell(pos_ori.x, pos_ori.y+j)
	else:
		for j in range(diff_y+1):
			for i in range(diff_x+1):
				reset_cell(pos_ori.x+i, pos_ori.y+j)

func fill_selected_cells(pos_ori, pos_fina, tile_index):
	var diff_x = abs(pos_fina.x-pos_ori.x)
	var diff_y = abs(pos_fina.y-pos_ori.y)
	
	if pos_fina.x < pos_ori.x:
		pos_fina.x+=diff_x
		pos_ori.x-=diff_x
		
	if pos_fina.y < pos_ori.y:
		pos_fina.y+=diff_y
		pos_ori.y-=diff_y
	
	if diff_y == 0 and diff_x>0:
		for i in range(diff_x+1):
			set_cell(pos_ori.x+i, pos_ori.y, tile_index)
	elif diff_x == 0:
		for j in range(diff_y+1):
			set_cell(pos_ori.x, pos_ori.y+j, tile_index)
	else:
		for j in range(diff_y+1):
			for i in range(diff_x+1):
				set_cell(pos_ori.x+i, pos_ori.y+j, tile_index)

func reset_fill_selected_cells(pos_ori, old_pos_fina, new_pos_fina, tile_index):
	var diff_x_old = abs(old_pos_fina.x-pos_ori.x)
	var diff_x_new = abs(new_pos_fina.x-pos_ori.x)

	if diff_x_old < diff_x_new:
		#fill_x
	else:
		#reset_x

	var diff_y_old = abs(old_pos_fina.y-pos_ori.y)
	var diff_y_new = abs(new_pos_fina.y-pos_ori.y)

	if diff_y_old < diff_y_new:
		#fill_y
	else:
		#reset_x

	

func _process(delta):
	if Input.is_action_just_pressed("mouse_left_button"):
		select_start = get_pos_selected_cell()
		select_tmp = select_start
		mouseBool=true
	
	if mouseBool:
		var v = get_pos_selected_cell()
		if v != select_tmp:
			reset_selected_cells(select_start, select_tmp)
			select_tmp = v
			fill_selected_cells(select_start, select_tmp, 3)
	
	if Input.is_action_just_released("mouse_left_button"):
		mouseBool=false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

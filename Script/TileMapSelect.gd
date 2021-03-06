extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mouseBool = false
var select_start:Vector2
var select_tmp:Vector2

func fill_select(pos_ori, pos_fina, tile_index):
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouse_left_button"):
		select_start = world_to_map(get_global_mouse_position())
		select_tmp = select_start
		mouseBool=true
	
	if mouseBool:
		var v = world_to_map(get_global_mouse_position())
		if v != select_tmp:
			fill_select(select_start, select_tmp, -1)
			select_tmp = v
			fill_select(select_start, select_tmp, 3)
	
	if Input.is_action_just_released("mouse_left_button"):
		mouseBool=false
	pass

extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mouseBool = false
var select_start:Vector2
var select_tmp:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouse_left_button"):
		select_start = world_to_map(get_global_mouse_position())
		select_tmp = select_start
		set_cell(select_start.x, select_start.y, 3)
		mouseBool=true
	
	if mouseBool:
		var v = world_to_map(get_global_mouse_position())
		if v != select_tmp:
			for i in range(select_tmp.x-select_start.x):
				set_cell(select_start.x+i,select_start.y,-1)
			select_tmp = v
			for i in range(select_tmp.x-select_start.x):
				set_cell(select_start.x+i,select_start.y,3)
	
	if Input.is_action_just_released("mouse_left_button"):
		set_cell(select_start.x, select_start.y, -1)
		mouseBool=false
	pass

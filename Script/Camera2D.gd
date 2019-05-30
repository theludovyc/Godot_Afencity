extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var mouseBool = false
var mousePosTmp:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= 1
		
	if Input.is_action_pressed("ui_right"):
		position.x += 1
		
	if Input.is_action_pressed("ui_up"):
		position.y -= 1
		
	if Input.is_action_pressed("ui_down"):
		position.y += 1
	
	if Input.is_action_just_pressed("mouse_right_button"):
		mousePosTmp=get_viewport().get_mouse_position()
		mouseBool=true
		
	if mouseBool:
		var mousePos=get_viewport().get_mouse_position()
		var mouseDelta=mousePosTmp-mousePos
		mousePosTmp=mousePos
		position += mouseDelta * 0.5
		
	if Input.is_action_just_released("mouse_right_button"):
		mouseBool=false
	pass

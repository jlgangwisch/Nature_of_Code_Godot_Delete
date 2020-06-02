extends Node2D
onready var mouse_position = get_viewport().get_mouse_position()
onready var viewport_size = get_viewport().get_visible_rect().size

#dividing a vector
onready var center = viewport_size/2

onready var line_start = Vector2(0,0)

#subtracting a vector
onready var line_end = Vector2()
export var line_scale = 0.5
export var line_width = 1.0

func _process(delta):
	#refresh mouse_position
	mouse_position = get_viewport().get_mouse_position()
	
	#subtracting vectors
	mouse_position -= center
	line_start = center
	
	

	#scaling/multiplying
	#line_end = mouse_position * line_scale
	
	#normalizing a vector
	line_end = mouse_position.normalized() *100
	
	#adding vectors
	line_end += center

	print(mouse_position, line_end)



	
	update()

func _draw():
	draw_line(line_start, line_end, Color(1.0,1.0,1.0), line_width)

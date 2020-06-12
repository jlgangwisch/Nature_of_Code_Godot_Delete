extends Node2D

onready var screen_size = get_viewport().get_visible_rect().size

var v1
var v2 = Vector2(0,0)
var v3 = Vector2(0,0)

func _ready():
	v1 = Vector2(100,0)
	#v1 += screen_size/2

func _process(delta):
	v2 = Vector2(0,100)
	#v2 += screen_size/2
	v3 = get_global_mouse_position()-screen_size/2

	
	print("radians: " ,v3.angle_to(v1))
	print("degrees: ", rad2deg(v3.angle_to(v1)))
	print("dot: ", v1.dot(v3))
	update()

func _draw():
	draw_line(screen_size/2, v1+screen_size/2, Color(1,1,1))
	draw_line(screen_size/2, v3+screen_size/2, Color(1,1,1))

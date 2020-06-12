extends Node2D

class_name Path_06_05

onready var screen_size = get_viewport().get_visible_rect().size

var start = Vector2(0,0)
var end = Vector2(0,0)
var radius = 20

func _ready():
	start = Vector2(0, screen_size.y/3)
	end = Vector2(screen_size.x, 2* screen_size.y/3)
	
func _draw():
	draw_line(start, end, Color(0.25,0.25,0.25,0.25), radius*2)
	draw_line(start, end, Color(1,0,0))



extends Node2D

class_name Path_06_06

onready var win_size = get_viewport().get_visible_rect().size

#var start = Vector2(0,0)
#var end = Vector2(0,0)
var points = PoolVector2Array([])
var radius = 20

func _ready():
	points.append(Vector2(0,win_size.y/2))
	points.append(win_size/4)
	points.append(win_size/4*3)
	points.append(Vector2(win_size.x,win_size.y/2))
	pass

func add_point(vec2):
	points.append(vec2)
	

func _draw():
	draw_polyline(points, Color(0.25,0.25,0.25,0.25), radius*2)
	draw_polyline(points, Color(1,0,0))



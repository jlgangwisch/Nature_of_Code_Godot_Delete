extends Node2D

class_name Path_e06_13

onready var win_size = get_viewport().get_visible_rect().size

#var start = Vector2(0,0)
#var end = Vector2(0,0)
var points = PoolVector2Array([])
var radius = 10

func _ready():
	points.append(Vector2(100,100))
	points.append(Vector2(win_size.x-100,100))
	points.append(Vector2(win_size.x-100,win_size.y-100))
	points.append(win_size/2)
	points.append(Vector2(100,win_size.y-100))
	points.append(Vector2(100,100))
	pass

func add_point(vec2):
	points.append(vec2)
	

func _draw():
	draw_polyline(points, Color(0.25,0.25,0.25,0.25), radius*2)
	draw_polyline(points, Color(1,0,0))



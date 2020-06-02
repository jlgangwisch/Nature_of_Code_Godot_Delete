extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size


var center


export var circle_radius = 10.0
export var circle_color = Color(0,0,0)
export var line_scale = 0.5
export var line_width = 1.0

var angle = Vector2()
var amplitude = Vector2()
var velocity = Vector2()
var target = Vector2()
var offset

func _ready():
	randomize()
	center = Vector2 (viewport_size.x/2, viewport_size.y/2) 
	velocity = Vector2(0.1, 0.05)
	amplitude = Vector2(100,10)

func _physics_process(delta):
	#var x = amplitude.x * sin(angle.x)
	var y = amplitude.y * sin(angle.y)
	target = Vector2(0 + center.x+offset, y+center.y)
	update()
	oscillate()



func _draw():
	var line_start = Vector2(center.x,center.y)
	var line_end = target
	draw_line(line_start, line_end, Color(1.0,1.0,1.0), line_width)
	draw_circle(target, circle_radius, circle_color)

func oscillate():
	angle += velocity

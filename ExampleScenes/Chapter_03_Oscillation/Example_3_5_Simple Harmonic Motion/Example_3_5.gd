extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size
onready var circle = get_node("Circle")

export var line_scale = 0.5
export var line_width = 1.0

var center
var line_start
var line_end

var circle_radius = 10.0
export var circle_color = Color(0,0,0)
var frame_count = 0;

var r = 75.0
var theta = 0.0
var amplitude = 100.0
var period = 120.0
var target

func _ready():
	center = Vector2 (viewport_size.x/2, viewport_size.y/2) 
	pass

func _physics_process(delta):
	var x = amplitude * cos(2 * PI * frame_count / period)
	target = Vector2(x + center.x, center.y)
	
	theta += delta
	line_start = center
	line_end = target
	update()
	frame_count += 1

func _draw():
	
	draw_line(line_start, line_end, Color(1.0,1.0,1.0), line_width)
	draw_circle(target, circle_radius, circle_color)

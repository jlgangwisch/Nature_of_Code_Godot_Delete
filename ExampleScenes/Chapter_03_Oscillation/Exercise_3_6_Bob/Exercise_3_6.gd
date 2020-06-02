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
var angle = 0
var aVelocity = 0.05
var target

func _ready():
	center = Vector2 (viewport_size.x/2, viewport_size.y/2) 
	pass

func _physics_process(delta):
	var x = amplitude * cos(angle)
	target = Vector2(x + center.x,center.y)
	
	line_start = center
	line_end = target
	update()
	angle += aVelocity

func _draw():
	
	draw_line(line_start, line_end, Color(1.0,1.0,1.0), line_width)
	draw_circle(target, circle_radius, circle_color)
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

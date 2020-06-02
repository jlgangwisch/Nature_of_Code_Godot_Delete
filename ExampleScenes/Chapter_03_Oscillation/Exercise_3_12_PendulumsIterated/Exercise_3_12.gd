extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size


var origin


export var circle_radius = 10.0
export var circle_color = Color(0,0,0)
export var line_scale = 0.5
export var line_width = 1.0
export var arm_length = 100
var angle = 0.0
var aVelocity = 0.0
var aAcceleration = 0.0
var bob_position = Vector2()

func _ready():
	randomize()
	origin = Vector2 (viewport_size.x/2, viewport_size.y/2) 
	angle = PI/4
	

func _physics_process(delta):
	var gravity = 0.4
	aAcceleration = (-1* gravity * sin(angle)) / arm_length
	aVelocity += aAcceleration
	bob_position = Vector2(arm_length * sin(angle), arm_length * cos(angle))
	bob_position += origin
	angle += aVelocity
	angle = angle * 0.99
	update()


func _draw():
	var line_start = Vector2(origin.x,origin.y)
	var line_end = bob_position
	draw_line(line_start, line_end, Color(1.0,1.0,1.0), line_width)
	draw_circle(bob_position, circle_radius, circle_color)



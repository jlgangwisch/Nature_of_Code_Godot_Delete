extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var x = position.x
onready var y = position.y
export var speed_x = 10
export var speed_y = 30.3
export var circle_radius = 10.0
export var circle_color = Color(1.0,1.0,1.0)

func _draw():
	draw_circle(position, circle_radius,circle_color)
	
func _physics_process(delta):
	position.x += speed_x
	position.y += speed_y
	
	if x < 0 or x > viewport_size.x:
		speed_x *= -1
	if y < 0 or y > viewport_size.y:
		speed_y *= -1

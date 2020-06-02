extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

export var velocity = Vector2(2.5,5)
export var circle_radius = 10.0
export var circle_color = Color(1.0,1.0,1.0)

func _draw():
	draw_circle(position, circle_radius,circle_color)
	
func _physics_process(delta):
	
	position += velocity

	if position.x < 0 or position.x > viewport_size.x:
		velocity.x *= -1
	if position.y < 0 or position.y > viewport_size.y:
		velocity.y *= -1

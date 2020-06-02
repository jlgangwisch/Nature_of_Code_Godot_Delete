extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

export var velocity = Vector2(0,0)
export var acceleration = Vector2(-0.001, 0.01);
export var top_speed = 10


func _physics_process(delta):
	
	velocity += acceleration
	velocity.clamped(top_speed)
	
	position += velocity

	check_edges()
	
func check_edges():
	if position.x > viewport_size.x:
		position.x =0
	elif position.x< 0:
		position.x = viewport_size.x
	if position.y > viewport_size.y:
		position.y = 0
	if position.y < 0:
		position.y = viewport_size.y
	


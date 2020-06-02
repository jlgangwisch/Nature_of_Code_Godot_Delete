extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var mouse_position = get_viewport().get_mouse_position()

export var velocity = Vector2(0,0)
export var acceleration = Vector2(0,0);
export var top_speed = 10
export var scalar = 0.5

func ready():
	position = viewport_size/2

func _physics_process(delta):
	mouse_position = get_viewport().get_mouse_position()
	
	var distance =mouse_position-position
	var direction = distance
	direction = direction.normalized()
	
	direction *= scalar
	
	acceleration = direction 
	
	velocity += acceleration
	velocity = velocity.clamped(top_speed)
	print(velocity.length())
	
	position += velocity

	

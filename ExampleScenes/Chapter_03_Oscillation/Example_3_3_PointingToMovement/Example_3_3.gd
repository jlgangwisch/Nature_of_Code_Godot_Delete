

extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var movers = get_node("Movers").get_children()



const GRAVITY = 0.4


func _ready():
	randomize()
	
	for mover in movers:
		mover.position = Vector2(rand_range(0,viewport_size.x),rand_range(0,viewport_size.y))
		mover.mass = rand_range(10,100)
		mover.get_node("ColorRect").rect_size = Vector2(mover.mass/1,mover.mass/2)
		mover.get_node("ColorRect").rect_position = Vector2(-mover.mass/2, -mover.mass/4)
		mover.velocity = Vector2(rand_range(-1,1), rand_range(-1,1))
	
		
		
func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()

	
	for mover in movers:
		var direction = mouse_pos - mover.position
		#the look_at() function was built to do this.
		var angle = atan2(mover.velocity.y, mover.velocity.x)
		direction = direction.normalized()
		mover.acceleration = direction * 0.5
		mover.angle = angle
		print(angle)
		

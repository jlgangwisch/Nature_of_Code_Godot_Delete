extends Node2D



onready var viewport_size = get_viewport().get_visible_rect().size

var velocity = Vector2()
var acceleration = Vector2()
var emitter_pos = Vector2()
var mass = 1.0


export var lifespan = 1.0

func _ready():
	acceleration = Vector2(0, 0.5)
	velocity = Vector2(rand_range(-10,10), rand_range(-20,0))
	emitter_pos = Vector2(0,0)
	lifespan = 1.0
	position = emitter_pos
	
func _physics_process(delta):
	velocity += acceleration
	position += velocity
	lifespan -= .02
	update()
	if is_dead():
		queue_free()
	
func _draw():
	draw_circle(Vector2(0,0), 8, Color(1,1,1,lifespan))
	
func apply_force(force):
	force /= mass
	acceleration += force

func is_dead():
	if lifespan < 0.0:
		return true
	else:
		return false

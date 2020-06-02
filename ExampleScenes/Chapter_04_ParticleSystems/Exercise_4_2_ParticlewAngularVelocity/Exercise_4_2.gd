extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var velocity = Vector2()
var acceleration = Vector2()
var emitter_pos = Vector2()
var mass = 1.0
var aAcceleration = 0.0
var aVelocity = 0.0
var angle = 0.0

export var lifespan = 1.0

func _ready():
	acceleration = Vector2(0, 0.5)
	velocity = Vector2(rand_range(-10,10), rand_range(-20,0))
	emitter_pos = viewport_size/2
	lifespan = 1.0
	position = emitter_pos
	
func _physics_process(delta):
	velocity += acceleration
	position += velocity
	
	aAcceleration = velocity.x * 0.001
	aVelocity += aAcceleration
	angle += aVelocity
	rotation = angle
	print(rotation)
	
	lifespan -= .02
	
	update()
	if is_dead():
		_ready()
	
func _draw():
	var radius = mass *10
	var vertice1 = Vector2(-radius,-radius)
	var vertice2 = Vector2(0,radius)
	var vertice3 = Vector2(radius, -radius)
	var vertices = PoolVector2Array([vertice1, vertice2, vertice3])
	
	draw_colored_polygon(vertices,Color(1,1,1,lifespan))

func is_dead():
	if lifespan < 0.0:
		return true
	else:
		return false

	
func apply_force(force):
	force /= mass
	acceleration += force

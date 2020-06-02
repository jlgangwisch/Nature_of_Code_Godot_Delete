extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var particle_system = get_parent().get_node("ParticleSystem")

var radius = 10
var speed = 10
var turn_speed = 10
var top_speed = 10

var velocity = Vector2()
var acceleration = Vector2()
var aVelocity = float()
var aAcceleration = float()



func _ready():
	position = viewport_size/2

func _physics_process(delta):
	
	get_input(delta)
	check_edges()
	
	velocity += acceleration
	velocity = velocity.clamped(top_speed)
	position += velocity
	acceleration *=0
	
	aVelocity += aAcceleration
	rotation += aVelocity
	aAcceleration *= 0
	aVelocity *=0
	
	update()
	
func _draw():
	var vertice1 = Vector2(0,radius)
	var vertice2 = Vector2(radius,0)
	var vertice3 = Vector2(0, -radius)
	var	shape = PoolVector2Array([vertice1, vertice2, vertice3])
	draw_colored_polygon(shape, Color(1,1,1))
	
func get_input(delta):
	if Input.is_action_pressed("ui_up"):
		#acceleration = Vector2(cos(rotation), sin(rotation))
		acceleration = Vector2(1,1).rotated(rotation)
		acceleration *= speed * delta
		particle_system.is_on = true
	else:
		particle_system.is_on = false
	#elif Input.is_action_pressed("ui_down"):
		#acceleration = Vector2(cos(rotation), sin(rotation))
		#acceleration *= -speed * delta
	if Input.is_action_pressed("ui_left"):
		aAcceleration -= turn_speed * delta
	elif Input.is_action_pressed("ui_right"):
		aAcceleration += turn_speed * delta

func check_edges():
	if position.x < 0:
		position.x += viewport_size.x
	elif position.x > viewport_size.x:
		position.x -= viewport_size.x
	elif position.y < 0:
		position.y += viewport_size.y
	elif position.y > viewport_size.y:
		position.y -= viewport_size.y
		
		
		
		
		

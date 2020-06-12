extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var target:Vector2

var vehicle = Vehicle_e06_04.new(Vector2(100,100), 10)
var radius = 50
var distance = 100
var ring = Vector2()
var theta = rand_range(0, 2*PI)

func _ready():
	target = Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y))
	add_child(vehicle)
	theta = rand_range(0, 2*PI)
	
func _physics_process(delta):
	theta += rand_range(-1,1)

	ring = Vector2(distance,0).rotated(vehicle.rotation)+ vehicle.position
	
	
	
	target.x = radius * cos(theta)
	target.y = radius * sin(theta)
	target += ring
	
	#target = get_global_mouse_position()
	update()
	
	vehicle.seek(target,delta)
	
func _draw():
	draw_circle(ring, radius, Color(0,0,1,0.5))
	draw_line(vehicle.position, ring,Color(1,0,0))
	draw_line(ring, target, Color(0,1,0))
	draw_circle(target, 2, Color(0,1,0))
	pass


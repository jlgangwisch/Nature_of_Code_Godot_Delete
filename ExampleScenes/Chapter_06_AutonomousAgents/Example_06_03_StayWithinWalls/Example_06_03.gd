extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var target:Vector2

var vehicle = Vehicle_06_03.new(Vector2(100,100), 10)
var radius = 50
var distance = 100
var ring = Vector2()
var theta = rand_range(0, 2*PI)
var wall_distance = 100
export var show_target= true

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

	vehicle.wall_avoidance(wall_distance, delta)
	
func _draw():
	if show_target:
		draw_wander_target()
	var v1 = Vector2(wall_distance,wall_distance)
	var v2 = Vector2(wall_distance, viewport_size.y - wall_distance)
	var v3 = Vector2(viewport_size.x - wall_distance, wall_distance)
	var v4 = Vector2(viewport_size.x - wall_distance, viewport_size.y - wall_distance)
	draw_polyline(PoolVector2Array([v1, v2,v4, v3, v1]), Color(1,1,1,0.2))
	pass

func draw_wander_target():
	draw_circle(ring, radius, Color(0,0,1,0.5))
	draw_line(vehicle.position, ring,Color(1,0,0))
	draw_line(ring, target, Color(0,1,0))
	draw_circle(target, 2, Color(0,1,0))

#for example 2_7 just duplicate the movers
#for exercise 2.8 look in the ready function and add more attractors 


extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var movers = get_node("Movers").get_children()
onready var attractors = get_node("Attractors").get_children()

const GRAVITY = 0.4


func _ready():
	randomize()
	
	for mover in movers:
		mover.position = Vector2(rand_range(0,viewport_size.x),rand_range(0,viewport_size.y))
		mover.mass = rand_range(1,10)
		mover.velocity = Vector2(rand_range(-1,1), rand_range(-1,1))
	
	for attractor in attractors:
		#to start attractor in middle
		#attractor.position = Vector2 (viewport_size.x/2, viewport_size.y/2)
		#for multiple attractors, example 2_8
		attractor.position = Vector2(rand_range(0,viewport_size.x),rand_range(0,viewport_size.y))
		attractor.mass = rand_range(5,20)
		
func _physics_process(delta):
	for mover in movers:
		for attractor in attractors:
			var attraction = process_attraction(mover, attractor)
			mover.apply_force(attraction)

func process_attraction(_mover, _attractor):
	var force = _attractor.position - _mover.position
	var distance = force.length()
	distance = clamp(distance, 5,25)
	print(distance)
	force = force.normalized()
	var strength = (GRAVITY * _attractor.mass * _mover.mass) / (distance * distance)
	force = force * strength
	return force

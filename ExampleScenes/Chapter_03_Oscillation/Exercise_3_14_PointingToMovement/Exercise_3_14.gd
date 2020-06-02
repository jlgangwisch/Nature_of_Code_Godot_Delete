#Create an example that simulates a box sliding down the incline with friction. Note that the magnitude of the friction force is equal to the normal force.
#Not 100% sure about this one

extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var movers = get_node("Movers").get_children()



const GRAVITY = 0.4
var angle = 0

func _ready():
	randomize()
	
	for mover in movers:
		mover.position = Vector2(viewport_size.x/2,viewport_size.y/2)
		#mover.mass = rand_range(10,100)
		mover.mass = 10
		mover.angle = rand_range(0, 2*PI)
		angle = mover.angle
		mover.get_node("ColorRect").rect_size = Vector2(mover.mass/1,mover.mass/2)
		mover.get_node("ColorRect").rect_position = Vector2(-mover.mass/2, -mover.mass/4)
		mover.velocity = Vector2(0, 0)
	
		
		
func _physics_process(delta):
	

	
	for mover in movers:
		var friction = process_friction(mover.velocity, mover.angle)
		mover.apply_force(friction)
		var normal = process_normal(mover.angle)
		mover.apply_force(normal)
		mover.apply_force(Vector2(0,GRAVITY))
		pass
	update()
	
func process_normal(angle):
	var normal_force =Vector2(GRAVITY * cos(angle), -GRAVITY)
	normal_force = normal_force.rotated(-PI/4)
	return normal_force

		
func process_friction(obj_velocity, angle):
	var friction = obj_velocity * -1
	friction = friction.normalized()
	var coefficient = .01
	var normal = GRAVITY * cos(angle)
	friction = friction * normal * coefficient
	return friction

func process_gravity_sloped(angle):
	var gravity_sloped = GRAVITY * sin(angle)
	return gravity_sloped



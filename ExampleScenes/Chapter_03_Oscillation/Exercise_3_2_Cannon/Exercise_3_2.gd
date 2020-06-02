#for example 2_7 just duplicate the movers
#for exercise 2.8 look in the ready function and add more attractors 


extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var movers = get_node("Movers").get_children()



const GRAVITY = 0.4
var mover_scene = preload("res://ExampleScenes/Chapter 3 _ Oscillation/Exercise_3_2_Cannon/Mover.tscn")
var mover = mover_scene.instance()

func _ready():
	randomize()
	
	for mover in movers:
		mover.position = Vector2(rand_range(0,viewport_size.x),rand_range(0,viewport_size.y))
		mover.mass = rand_range(10,100)
		mover.get_node("ColorRect").rect_size = Vector2(mover.mass,mover.mass)
		mover.get_node("ColorRect").rect_position = Vector2(-mover.mass/2, -mover.mass/2)
		mover.velocity = Vector2(rand_range(-1,1), rand_range(-1,1))
	
		
		
func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	
	
	if Input.is_action_just_released("ui_up"):
		get_node("Movers").call_deferred("add_child", mover)
		mover.position = Vector2(viewport_size.x/2, viewport_size.y)
		
		var direction = mouse_pos - mover.position
		direction = direction.normalized()
		print(mouse_pos, direction)
		mover.mass = rand_range(10,100)
		mover.get_node("ColorRect").rect_size = Vector2(mover.mass/2,mover.mass)
		mover.get_node("ColorRect").rect_position = Vector2(-mover.mass/2, -mover.mass/2)
		mover.velocity = Vector2(
		mover.acceleration = direction 
		
	
	for mover in movers:
		mover.apply_force(GRAVITY*mover.mass)
		var friction = process_friction(mover)
		mover.apply_force(friction)


func process_friction(obj_velocity):
	var friction = obj_velocity * -1
	friction = friction.normalized()
	var coefficient = .01
	var normal = 1
	friction = friction * normal * coefficient
	return friction

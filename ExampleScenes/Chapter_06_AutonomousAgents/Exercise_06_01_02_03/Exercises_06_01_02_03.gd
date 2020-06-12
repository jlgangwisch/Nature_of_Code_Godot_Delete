extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var target:Vector2
var target_color : Color = Color(1,0,0)

func _ready():
	randomize()
	target = Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y))
	var ex1 = Vehicle_e06_01.new(Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y)), 10)
	var ex2 = Vehicle_e06_01.new(Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y)), 10)
	var contrast_ex2 =  Vehicle_e06_01.new(Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y)), 10)
	var ex3 = Vehicle_e06_01.new(Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y)), 10)
	add_child(ex1)
	add_child(ex2)
	add_child(contrast_ex2)
	add_child(ex3)
	
func _process(delta):
	#for exercise 6_2
	var last_target_pos = target
	target = get_global_mouse_position()
	var predicted_pos = target + (target-last_target_pos)
	update()
	
	#Exercise 6_1, avoidance
	var ex1 = get_child(0)
	ex1.flee(target,delta)
	
	#exercise 6_2 chases the predicted position
	var ex2 = get_child(1)
	var not_ex2 = get_child(2)
	ex2.seek(predicted_pos,delta)
	ex2.color = Color(0,0,1,0.5)
	not_ex2.seek(target,delta)
	
	#all below for exercise 3
	var ex3 = get_child(3)
	if Input.is_action_pressed("ui_up"):
		target_color = Color(1,0,0)
		ex3.color = target_color
		ex3.max_speed = 0
	elif Input.is_action_pressed("ui_left"):
		target_color = Color(1,1,0)
		ex3.color = target_color
		ex3.max_speed = 4
	if Input.is_action_pressed("ui_right"):
		target_color = Color(0,1,0)
		ex3.color = target_color
		ex3.max_force = 1
		ex3.max_speed = 6
	else:
		ex3.max_force = 0.1
		ex3.max_speed = 4
	ex3.seek(ex2.position, delta)
		
	
	
func _draw():
	draw_circle(target, 20, Color(0,0,1,0.5))


extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var rect_width 
onready var rect_height

export var velocity = Vector2(0,0)
export var acceleration = Vector2(0,0)
export var top_speed = 10
export var mass = 100.0

#these variables are used in Exercise 2_4
var is_in_friction = false
var is_in_zoom = false
#2_5
var is_in_liquid = false

func _ready():
	rect_width = mass * rand_range(0.2,0.8)
	rect_height = mass - rect_width
	var collider = get_node("CollisionShape2D")
	var rect = get_node("ColorRect")
	var shape = RectangleShape2D.new()
	rect.rect_size = Vector2(rect_width,rect_height)
	shape.extents = Vector2(rect_width/2, rect_height/2)
	collider.set_shape(shape)
	collider.position = Vector2(rect_width/2,rect_height/2)
	


func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		acceleration.x += 0.1
	if Input.is_action_pressed("ui_left"):
		acceleration.x -= 0.1
	if Input.is_action_pressed("ui_down"):
		acceleration.y += 0.1
	if Input.is_action_pressed("ui_up"):
		acceleration.y -= 0.1
	velocity += acceleration
	#velocity = velocity.clamped(top_speed)
	position += velocity
	acceleration *= 0;

	check_edges()
	#print(velocity)

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output


func apply_force(force):
	force /= mass
	acceleration += force

	
func check_edges():
	if position.x < 0 or position.x > viewport_size.x:
		velocity.x *= -1
	if position.y < 0 or position.y > viewport_size.y-rect_height:
		velocity.y *= -1
		

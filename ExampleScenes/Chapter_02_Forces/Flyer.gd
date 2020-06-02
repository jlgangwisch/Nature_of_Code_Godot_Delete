extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

export var velocity = Vector2(0,0)
export var acceleration = Vector2(0,0)
export var top_speed = 10
export var mass = 1.0

#these variables are used in Exercise 2_4
var is_in_friction = false
var is_in_zoom = false
#2_5
var is_in_liquid = false

func _ready():
	var shape = CircleShape2D.new()
	shape.set_radius(mass)
	get_node("CollisionShape2D").set_shape(shape)


func _physics_process(delta):

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
	if position.y < 0 or position.y > viewport_size.y:
		velocity.y *= -1
		

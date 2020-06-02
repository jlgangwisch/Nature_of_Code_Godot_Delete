extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

export var velocity = Vector2(0,0)
export var acceleration = Vector2(0,0)
export var top_speed = 10
export var mass = 1.0

var angle = 0.0
var aVelocity = 0.0
var aAcceleration = 0.0

func _ready():
	var shape = CircleShape2D.new()
	shape.set_radius(mass)
	get_node("CollisionShape2D").set_shape(shape)
	
	var rect = get_node("ColorRect")
	rect.rect_position = Vector2(-mass/2, -mass/2)
	rect.rect_size= Vector2(mass,mass)


func _physics_process(delta):



	velocity += acceleration
	#velocity = velocity.clamped(top_speed)
	position += velocity
	acceleration *= 0;
	
	
	aVelocity += aAcceleration
	angle += aVelocity
	rotation = angle
	aAcceleration *= 0
	update()
	#check_edges()
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
		
		

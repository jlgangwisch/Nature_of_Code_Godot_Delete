extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size
onready var parent = get_parent()

export var circle_radius = 10.0

export var normal_color = Color(1,1,1)
export var hover_color = Color (0,1,1)
export var damping = 0.98
export var mass = 24

var circle_color = Color(1,1,1)

var angle = 0.0
var aVelocity = 0.0
var aAcceleration = 0.0
var bob_position = Vector2()

var acceleration = Vector2()
var velocity = Vector2()

var mouse_drag = false
var mouse_click = false

func _ready():
	randomize()	
	var shape = CircleShape2D.new()
	shape.set_radius(circle_radius)
	get_node("CollisionShape2D").set_shape(shape)
	
func _physics_process(delta):
	
	if mouse_drag:
		position = get_global_mouse_position() - get_parent().position
	else:
		velocity += acceleration
		velocity = velocity * damping
		position += velocity
		acceleration = acceleration * 0
	
	update()

	

func _draw():
	
	draw_circle(bob_position, circle_radius, circle_color)

func apply_force(force):
	force /= mass
	acceleration += force

	


func _on_Bob_mouse_entered():
	circle_color = hover_color



func _on_Bob_mouse_exited():
	circle_color = normal_color
	


func _on_Bob_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if event.is_pressed():
			mouse_drag = true
		else:
			mouse_drag = false
			


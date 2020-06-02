extends Node2D

class_name PointMass_5_14

var velocity := Vector2(0,0)
var previous_position := Vector2(0,0)

var mass: float = 1.0 setget set_mass
var inverted_mass: float = 1.0 / mass

var neighbors: Array = []

var projected_position := Vector2.ZERO
var correction_projection := Vector2.ZERO

export(bool) var is_static:bool = false setget set_static

var color = Color(1,0,0,0.5)
var radius = 5

func _ready():
	var shape = CircleShape2D.new()
	var collider = CollisionShape2D.new()
	shape.radius = radius
	collider.set_shape(shape)
	
	
	previous_position = position - velocity * get_physics_process_delta_time()
	projected_position = position
	correction_projection = Vector2.ZERO
	
func _process(delta):
	update()

func set_mass(new_mass):
	mass = max(new_mass,0.1)
	inverted_mass = pow(new_mass, -1.0)
	
func add_neighbor(point_mass):
	neighbors.append(point_mass)
#
func set_static(value):
	is_static = value
	if is_static:
		color = Color( 1.0, 0.0, 0.0, 0.5 )
	else:
		color = Color( 0,1,0,0.5)

func _draw():
	draw_circle(Vector2.ZERO, radius, color)

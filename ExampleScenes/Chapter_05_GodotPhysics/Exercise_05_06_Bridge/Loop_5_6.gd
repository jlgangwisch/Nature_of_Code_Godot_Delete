extends RigidBody2D

class_name Loop_5_6

var extents = Vector2(10,10)
var radius = extents.x
var shape = CircleShape2D.new()
var collision = CollisionShape2D.new()

func _ready():
	shape.radius = radius
	collision.set_shape(shape)
	add_child(collision)

func _draw():
	var center = Vector2(0,0)
	var color = Color(1,0,0,0.5)
	#draw_circle_arc(center, radius, 0, PI, color)
	draw_circle(center, radius, color)

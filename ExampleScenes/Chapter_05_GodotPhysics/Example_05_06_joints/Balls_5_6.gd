extends RigidBody2D

class_name Balls_5_6

var shape = CircleShape2D.new()
var collision = CollisionShape2D.new()
var size = 10

func _ready():
	shape.set_radius(size)
	collision.set_shape(shape)
	
	add_child(collision)

	
func _draw():
	draw_circle(Vector2(0,0), 10, Color(1,1,1))
	draw_line(Vector2(0,0), Vector2(10,0), Color(1,0,0))

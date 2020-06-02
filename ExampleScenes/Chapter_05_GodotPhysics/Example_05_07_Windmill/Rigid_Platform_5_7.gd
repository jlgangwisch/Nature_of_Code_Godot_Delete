extends RigidBody2D

class_name Rigid_Platform_5_6

var extents = Vector2(10,10)

var shape = RectangleShape2D.new()
var collision = CollisionShape2D.new()

func _ready():
	shape.extents = extents
	collision.set_shape(shape)
	add_child(collision)

func _draw():
	var pos = -extents
	var size = extents*2
	var rect = Rect2(pos, size)
	var center = Vector2(0,0)
	var color = Color(0,1,0,0.5)
	#draw_circle_arc(center, radius, 0, PI, color)
	draw_rect(rect, color)

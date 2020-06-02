extends PinJoint2D

class_name PinLink_5_6

var extents = Vector2(10,5)

var shape = RectangleShape2D.new()
var collision = CollisionShape2D.new()

func _ready():
	shape.extents = extents
	collision.set_shape(shape)


func _draw():
	var pos = -extents
	var size = 2*extents
	var rect = Rect2(pos, size)
	var center = Vector2(0,0)
	var color = Color(0,0,1,0.5)
	#draw_circle_arc(center, radius, 0, PI, color)
	draw_rect(rect, color)

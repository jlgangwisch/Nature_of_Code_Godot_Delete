extends Node2D

class_name Balls_Connected_Spring_5_6

var ball1 = Balls_5_6.new()
var ball2 = Balls_5_6.new()
var joint = DampedSpringJoint2D.new()
var spacer = 10

func _ready():
	ball1.position.x -= spacer/2
	ball2.position.x += spacer/2
	add_child(ball1)
	add_child(ball2)
	joint.node_a = ball1.get_path()
	joint.node_b = ball2.get_path()
	add_child(joint)

func _process(delta):
	update()
	
func _draw():
	draw_line(ball1.position, ball2.position, Color(0,0,1))

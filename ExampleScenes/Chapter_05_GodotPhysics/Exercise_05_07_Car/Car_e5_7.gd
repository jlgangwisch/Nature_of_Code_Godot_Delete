extends Node2D

class_name Car_e5_7

var tire1 = Tire_e5_7.new()
var tire2 = Tire_e5_7.new()
var body = CarBody_e5_7.new()
var axle1 = PinJoint2D.new()
var axle2 = PinJoint2D.new()


var body_size = 100
var tire_radius = 50

var motor = 0
var speed = 100


func _ready():
	tire1.position.x = -body_size/2
	tire2.position.x = body_size/2
	tire1.radius = 20
	tire2.radius=20
	body.extents = Vector2(body_size/2, body_size/4)
	body.position.y -= body.extents.y
	add_child(tire1)
	add_child(tire2)
	add_child(body)
	
	
	
	axle1.position = tire1.position
	axle2.position = tire2.position
	axle1.node_a = tire1.get_path()
	axle1.node_b = body.get_path()
	axle2.node_a = tire2.get_path()
	axle2.node_b = body.get_path()
	add_child(axle1)
	add_child(axle2)

func _process(delta):
	if motor == -1:
		tire1.apply_torque_impulse(-speed)
	elif motor == 1:
		tire1.apply_torque_impulse(speed)
	
	update()


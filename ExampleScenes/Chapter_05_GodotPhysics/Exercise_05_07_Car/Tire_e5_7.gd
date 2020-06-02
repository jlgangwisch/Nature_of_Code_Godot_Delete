extends RigidBody2D

class_name Tire_e5_7

var collider = CollisionShape2D.new()

var radius = 20
var spokes = 10

func _ready():
	var shape = CircleShape2D.new()
	shape.radius = radius
	collider.set_shape(shape) 
	add_child(collider)
	
	var mat = PhysicsMaterial.new()
	mat.set_friction(1)
	mat.set_rough(true)
	mat.set_bounce(0)
	set_physics_material_override(mat)
	
func _draw():

	draw_circle(Vector2(0,0), radius, Color(1,1,1))
	for i in range(spokes):
		var angle = (2*PI) / spokes
		draw_line(Vector2(0,0), Vector2(radius,0).rotated(i*angle), Color(1,0,0))

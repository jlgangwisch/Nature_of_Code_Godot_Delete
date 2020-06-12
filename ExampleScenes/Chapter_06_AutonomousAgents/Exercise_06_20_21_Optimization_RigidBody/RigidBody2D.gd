extends RigidBody2D

onready var size = $CollisionShape2D.shape.radius*0
onready var viewport_size = get_viewport().get_visible_rect().size

func _integrate_forces(state):
	var xform = state.get_transform()
	if xform.origin.x < 0-size:
		xform.origin.x += viewport_size.x+size
	elif xform.origin.x > viewport_size.x+size:
		xform.origin.x -= viewport_size.x+size
	elif xform.origin.y < 0-size:
		xform.origin.y += viewport_size.y+size
	elif xform.origin.y > viewport_size.y+size:
		xform.origin.y -= viewport_size.y+size
	print(xform.origin)
	state.set_transform(xform)

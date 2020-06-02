extends RigidBody2D

onready var collider = get_node("CollisionShape2D")

var radius = 0

var color = Color(0,1,1)
var n_color = Color(0,1,1)
var h_color = Color (0.5,0.5,0.5)

func _ready():
	radius = get_parent().bob_radius
	collider.shape.radius = radius

func _process(delta):
	
	update()
	
func _integrate_forces(state):
		if color == h_color && Input.is_action_pressed("left_mouse"):
			var xform = state.get_transform()
			xform.origin = get_global_mouse_position()
			state.set_transform(xform)
	
func _draw():
	draw_circle(Vector2(0,0),radius,color)





func _on_Bob_5_10_mouse_entered():
	color = h_color
	pass # Replace with function body.


func _on_Bob_5_10_mouse_exited():
	color = n_color
	pass # Replace with function body.

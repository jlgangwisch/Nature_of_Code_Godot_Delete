extends Node2D

const GRAVITY = 1.0
onready var spring = get_node("Spring")
onready var bob = get_node("Bob")

func _process(delta):
	var gravity = Vector2(0,GRAVITY)
	bob.apply_force(gravity)
	
	spring.spring_connect(bob)
	spring.constrain_length(bob,30,200)
	
	update()


func _on_Bob_mouse_exited():
	pass # Replace with function body.
	
func _draw():
	draw_line(bob.position, spring.anchor_pos, Color(0.9,0.9,0.9))

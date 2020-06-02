extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var bob = get_node("Bob_5_10")
onready var anchor = get_node("Anchor_5_10")
onready var spring = get_node("Spring_5_10")

export var anchor_size = Vector2(30,30)
export var bob_radius = 25
export var max_length = 200
export var rest_length = 150


func _ready():
	position = Vector2(viewport_size.x/2, 100)
	bob.position = Vector2(0,rest_length)
	spring.set_length(max_length)
	spring.set_rest_length(150)



func _on_Bob_5_10_body_shape_exited(body_id, body, body_shape, local_shape):
	pass # Replace with function body.

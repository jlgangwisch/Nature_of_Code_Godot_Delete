extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(viewport_size.x/2, viewport_size.y/2)
	pass # Replace with function body.

func _physics_process(delta):
	rotation += 0.01
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

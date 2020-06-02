extends Node2D
onready var viewport_size = get_viewport().get_visible_rect().size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for mover in get_children():
		mover.position = Vector2(rand_range(0, viewport_size.x), rand_range(0, viewport_size.y))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

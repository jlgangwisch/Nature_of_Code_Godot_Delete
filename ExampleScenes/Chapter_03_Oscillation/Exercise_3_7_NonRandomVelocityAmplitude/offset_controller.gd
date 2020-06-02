extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var this = get_children()
	for oscillators in this:
		oscillators.offset = oscillators.get_index() * 100
		print(oscillators.get_index(), ", ", oscillators.offset)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

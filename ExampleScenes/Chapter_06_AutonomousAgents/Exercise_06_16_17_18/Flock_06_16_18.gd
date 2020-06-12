extends Node2D

class_name Flock_e06_16_18

func _process(delta):
	
	for b in get_children():
		b.flock(get_children())
		

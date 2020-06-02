extends Node2D

const PARTICLE = preload("Particle_4_4.tscn")


func _process(delta):
	var particle_instance = PARTICLE.instance()
	particle_instance.emitter_pos = get_global_mouse_position()
	add_child(particle_instance)
	

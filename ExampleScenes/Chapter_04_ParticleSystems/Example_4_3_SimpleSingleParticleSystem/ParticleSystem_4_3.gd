extends Node2D

const PARTICLE = preload("Particle_4_3.tscn")


func _process(delta):
	var particle_instance = PARTICLE.instance()
	particle_instance.emitter_pos = Vector2(512,100)
	add_child(particle_instance)
	

extends Node2D

const PARTICLE = preload("Particle_4_3.tscn")

func _process(delta):
	var particle_instance = PARTICLE.instance()
	add_child(particle_instance)

extends Node2D

const PARTICLE = preload("res://ExampleScenes/Chapter_4_ParticleSystems/Example_4_2_InstancingPackedScene/Particle_4_2.tscn")

func _process(delta):
	var particle_instance = PARTICLE.instance()
	add_child(particle_instance)

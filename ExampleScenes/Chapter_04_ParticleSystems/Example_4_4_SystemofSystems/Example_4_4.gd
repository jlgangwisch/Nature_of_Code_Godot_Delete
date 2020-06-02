extends Node2D

const PARTICLE_SYSTEM = preload("ParticleSystem_4_4.tscn")


func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		var particle_system = PARTICLE_SYSTEM.instance()
		particle_system.position = get_global_mouse_position()
		add_child(particle_system)
	

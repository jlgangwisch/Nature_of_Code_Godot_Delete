extends Node2D

const PARTICLE = preload("Particle_4_5.tscn")
var fuel = 100


func _process(delta):
	if fuel > 0:
		var particle_instance = PARTICLE.instance()
		particle_instance.emitter_pos = get_global_mouse_position()
		add_child(particle_instance)
		fuel -= 1
	else:
		if get_child_count() <= 1:
			print(get_parent().get_child_count()-1)
			queue_free()
			
	

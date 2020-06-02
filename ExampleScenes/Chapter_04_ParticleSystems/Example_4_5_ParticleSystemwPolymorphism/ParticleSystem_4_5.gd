extends Node2D

class_name ParticleSystem_4_5

	
func _physics_process(delta):
	var particle_instance = Particle_4_5.new()
	
	var r = randf()
	if r <0.5:
		particle_instance = Confetti_4_5.new()
	
	add_child(particle_instance)
	print(get_child_count())
	
	#if get_child_count() <= 1:
	#	print(get_parent().get_child_count()-1)
	#	queue_free()

extends Node2D

class_name ParticleSystem_e4_10

#const PARTICLE = preload("Particle_4_7.gd")

var emitter_pos = Vector2()

func _ready():
	#get_viewport().set_clear_mode(Viewport.CLEAR_MODE_NEVER)
	pass

func _physics_process(delta):
	emitter_pos = get_global_mouse_position()
	var particle_instance = Particle_e4_10.new()
	

	particle_instance.position = emitter_pos
	add_child(particle_instance)

	for p1 in get_children():
		for p2 in get_children():
			if p1 != p2:
				var r = p1.repel(p2)
				p2.apply_force(r)
	
	#if get_child_count() <= 1:
	#	print(get_parent().get_child_count()-1)
	#	queue_free()
func apply_force(force):
	for particle in get_children():
		particle.apply_force(force)

extends Node2D

class_name ParticleSystem_example4_9

#const PARTICLE = preload("Particle_4_6.gd")

var emitter_pos = Vector2()

func _ready():
	#get_viewport().set_clear_mode(Viewport.CLEAR_MODE_NEVER)
	pass

func _physics_process(delta):
	emitter_pos = get_global_mouse_position()
	var particle_instance = Particle_example4_9.new()
	
	var r = randf()
	particle_instance.position = emitter_pos
	add_child(particle_instance)

	
	#if get_child_count() <= 1:
	#	print(get_parent().get_child_count()-1)
	#	queue_free()
func apply_force(force):
	for particle in get_children():
		particle.apply_force(force)

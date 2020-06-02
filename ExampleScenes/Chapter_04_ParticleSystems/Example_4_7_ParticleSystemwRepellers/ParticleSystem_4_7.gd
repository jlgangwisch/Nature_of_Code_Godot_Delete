extends Node2D

class_name ParticleSystem_4_7

#const PARTICLE = preload("Particle_4_7.gd")

var emitter_pos = Vector2()

func _ready():
	#get_viewport().set_clear_mode(Viewport.CLEAR_MODE_NEVER)
	pass

func _physics_process(delta):
	emitter_pos = get_global_mouse_position()
	var particle_instance = Particle_4_7.new()
	
	var r = randf()
	if r <0.4:
		particle_instance = Confetti_4_7.new()
	elif r>0.4 && r < 0.8:
		particle_instance = Triconfetti_4_7.new()
	particle_instance.position = emitter_pos
	add_child(particle_instance)

	
	#if get_child_count() <= 1:
	#	print(get_parent().get_child_count()-1)
	#	queue_free()
func apply_force(force):
	for particle in get_children():
		particle.apply_force(force)

func apply_repeller(repeller):
	for particle in get_children():
		var force = repeller.repel(particle)
		particle.apply_force(force)

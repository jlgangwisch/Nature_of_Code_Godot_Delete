extends Node2D

class_name ParticleSystem_e4_12

onready var test1 = preload("test1.png")
onready var test2 = preload("res://.import/test2.png-ca92c2cc39eb757830fae1889167e656.stex")
onready var test = preload("test.png")

#const PARTICLE = preload("Particle_4_6.gd")

var emitter_pos = Vector2()

func _ready():
	#get_viewport().set_clear_mode(Viewport.CLEAR_MODE_NEVER)
	pass

func _physics_process(delta):
	emitter_pos = get_global_mouse_position()
	var particle_instance = Particle_e4_12.new()
	
	var r = randf()
	particle_instance.p_texture = test
	if r <0.3:
		particle_instance.p_texture = test1
	if r> 0.3 and r< 0.8:
		particle_instance.p_texture = test2
	particle_instance.position = emitter_pos
	add_child(particle_instance)

	
	#if get_child_count() <= 1:
	#	print(get_parent().get_child_count()-1)
	#	queue_free()
func apply_force(force):
	for particle in get_children():
		particle.apply_force(force)

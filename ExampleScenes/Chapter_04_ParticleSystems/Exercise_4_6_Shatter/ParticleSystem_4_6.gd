extends Node2D

const PARTICLE = preload("Particle_4_6.tscn")
var fuel = 1000
var cannon_extent = 100

func _ready():
	for particle in fuel:
		var particle_instance = PARTICLE.instance()
		particle_instance.emitter_pos = Vector2(rand_range(-cannon_extent, cannon_extent), rand_range(-cannon_extent,cannon_extent))
		add_child(particle_instance)
		
	
func _process(delta):
	
	if get_child_count() <= 1:
		print(get_parent().get_child_count()-1)
		queue_free()
			
	

extends Node2D

const PARTICLE = preload("Particle_4_4.tscn")
onready var ship = get_parent().get_node("Ship")
var is_on = false
var emitter_pos
var emitter_rotation

func _ready():
	emitter_pos = position
	
func _process(delta):
	if is_on:
		var particle_instance = PARTICLE.instance()
		emitter_pos = ship.position
		particle_instance.emitter_pos = emitter_pos
		
		emitter_rotation = ship.rotation
		particle_instance.emitter_rotation = emitter_rotation
		add_child(particle_instance)

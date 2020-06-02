extends Node2D

const GRAVITY = Vector2(0,0.01)

onready var ps = ParticleSystem_e4_10.new()


var repellors = 5
onready var window = get_viewport().get_visible_rect().size

func _ready():
	randomize()
	
	ps = ParticleSystem_e4_10.new()
	add_child(ps)
	


func _physics_process(delta):
	ps.apply_force(GRAVITY)
	

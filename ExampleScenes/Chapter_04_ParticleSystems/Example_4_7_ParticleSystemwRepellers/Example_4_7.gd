extends Node2D

const GRAVITY = Vector2(0,0.01)

onready var ps = ParticleSystem_e4_9.new()
onready var repeller = Repeller_e4_9.new()

func _ready():
	ps = ParticleSystem_4_e9.new()
	add_child(ps)
	
	repeller.position = get_viewport().get_visible_rect().size/2
	print (repeller.position)
	add_child(repeller)

func _physics_process(delta):
	ps.apply_force(GRAVITY)
	ps.apply_repeller(repeller)

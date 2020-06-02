extends Node2D

const GRAVITY = Vector2(0,0.01)

onready var ps = ParticleSystem_4_6.new()

func _ready():
	add_child(ps)

func _physics_process(delta):
	ps.apply_force(GRAVITY)

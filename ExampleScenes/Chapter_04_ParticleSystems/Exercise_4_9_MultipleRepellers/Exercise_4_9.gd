extends Node2D

const GRAVITY = Vector2(0,0.01)

onready var ps = ParticleSystem_e4_9.new()
onready var repeller_array = Node.new()

var repellors = 5
onready var window = get_viewport().get_visible_rect().size

func _ready():
	randomize()
	add_child(repeller_array)
	
	ps = ParticleSystem_4_7.new()
	add_child(ps)
	
	for repeller in repellors:
		var rep = Repeller_e4_9.new()
		rep.position = Vector2(rand_range(0,window.x), rand_range(0, window.y))
		rep.radius = rand_range(25,100)
		repeller_array.add_child(rep)
		print(repeller_array.get_child_count())

func _physics_process(delta):
	ps.apply_force(GRAVITY)
	for repeller in repeller_array.get_children():
		ps.apply_repeller(repeller)

#BlendMode implemented on Particle

extends Node2D

class_name Particle_example4_9

onready var viewport_size = get_viewport().get_visible_rect().size
onready var p_texture = preload("test.png")

var velocity = Vector2()
var acceleration = Vector2()
var lifetime = float()
var size = float()
var color = Color()
var mass = float()
var mat = CanvasItemMaterial.new()

func _ready():
	randomize()
	acceleration = Vector2(0,0)
	velocity = Vector2(rand_range(-1,1), rand_range(-2,0))
	lifetime = 1.0
	color = Color(randf(),randf(),randf())
	size = rand_range(5,10)
	mass = size
	
	#mat.set_blend_mode(BLEND_MODE_MIX)
	mat.set_blend_mode(BLEND_MODE_ADD)
	#mat.set_blend_mode(BLEND_MODE_SUB)
	#mat.set_blend_mode(BLEND_MODE_MUL)
	#mat.set_blend_mode(BLEND_MODE_PREMULT_ALPHA)
	#mat.set_blend_mode(BLEND_MODE_DISABLE)
	
	set_material(mat)
	print(mat.get_blend_mode())
	
func _physics_process(delta):
	
	velocity += acceleration
	position += velocity
	update()
	lifetime -= .01
	if lifetime < 0:
		queue_free()

#it looks like draw calls on every level, so to get around it create a custom function that includes the confetti shape.
func _draw():
	
	confetti_shape()
	
func confetti_shape():
	draw_texture(p_texture, Vector2(-8,-8))
	
func apply_force(force):
	var f = force
	f /= mass
	acceleration += f


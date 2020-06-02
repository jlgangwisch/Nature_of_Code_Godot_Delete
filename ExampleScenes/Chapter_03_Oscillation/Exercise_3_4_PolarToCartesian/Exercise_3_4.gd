extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size
onready var circle = get_node("Circle")


var r = 0
var theta = 0.0
var center

func _ready():
	viewport.set_clear_mode(Viewport.CLEAR_MODE_NEVER)
	pass

func _physics_process(delta):
	var x = r * cos(theta)
	var y = r * sin(theta)
	position = Vector2 (x+viewport_size.x/2, y+viewport_size.y/2) 
	r += delta* 10
	theta += delta
	

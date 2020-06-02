extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

export var mass = 1.0



func _ready():
	var shape = CircleShape2D.new()
	shape.set_radius(mass)
	get_node("CollisionShape2D").set_shape(shape)


func _physics_process(delta):
	pass

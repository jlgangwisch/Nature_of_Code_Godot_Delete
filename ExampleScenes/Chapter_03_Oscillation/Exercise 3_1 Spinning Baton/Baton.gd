extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var angle = 0.0
var aVelocity = 0
var aAcceleration = 0.001


func _ready():
	position = Vector2(viewport_size.x/2, viewport_size.y/2)


func _physics_process(delta):
	rotation = angle
	aVelocity += aAcceleration
	angle += aVelocity

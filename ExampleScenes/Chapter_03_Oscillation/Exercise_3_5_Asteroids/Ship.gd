extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

export var velocity = Vector2(0,0)
export var speed = 20
export var rotation_speed = 1.5
export var top_speed = 10
export var mass = 1.0


var rotation_dir = 0.0

func _ready():
	position = Vector2(viewport_size.x/2, viewport_size.y/2)
	pass


func _physics_process(delta):
	
	get_input()
	rotation += rotation_dir * delta * 0.1
	position += velocity * delta 
	



func get_input():
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed,0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-speed,0).rotated(rotation)
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir += -1

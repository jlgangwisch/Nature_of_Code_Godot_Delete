extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size


var car = Car_e5_7.new()

func _ready ():

	car.position = Vector2(viewport_size.x/2,0)
	add_child(car)
	
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		car.motor = -1
	elif Input.is_action_pressed("ui_right"):
		car.motor = 1
	else:
		car.motor = 0

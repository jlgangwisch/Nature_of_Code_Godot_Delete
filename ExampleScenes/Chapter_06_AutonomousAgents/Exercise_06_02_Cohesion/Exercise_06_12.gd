extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var vehicles = 20

func _ready():
	for i in range(vehicles):
		var v = Vehicle_e06_12.new(Vector2(rand_range(0,viewport_size.x),rand_range(0,viewport_size.y)), 20)
		$Vehicles.add_child(v)

func _process(delta):
	for v in $Vehicles.get_children():
		v.cohere($Vehicles.get_children())
	if Input.is_action_pressed("left_mouse"):
		var v = Vehicle_e06_12.new(get_global_mouse_position(),20)
		$Vehicles.add_child(v)

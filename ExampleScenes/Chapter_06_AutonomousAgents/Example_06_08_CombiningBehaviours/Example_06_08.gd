extends Node2D

onready var win_size = get_viewport().get_visible_rect().size

var vehicles = 20


var color1 = Color(0,0,0)
var color2 = Color(1,0,0)


func _ready():
	randomize()
	for v in range(vehicles):
		var vh = Vehicle_06_08.new(Vector2(rand_range(0,win_size.x), rand_range(0, win_size.y)), 20)
		vh.max_force = 1/vh.size
		$Vehicles.add_child(vh)


func _process(delta):
	for v in $Vehicles.get_children():
		v.apply_behaviours($Vehicles.get_children())
	if Input.is_action_pressed("left_mouse"):
		var vh = Vehicle_06_08.new(get_global_mouse_position(), 20)
		vh.max_force = 1/vh.size
		$Vehicles.add_child(vh)

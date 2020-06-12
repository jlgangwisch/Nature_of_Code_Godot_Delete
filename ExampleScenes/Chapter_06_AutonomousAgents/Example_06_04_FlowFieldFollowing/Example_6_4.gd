extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
var v_num = 200


func _ready():
	for v in range(v_num):
		var vehicle = Vehicle_06_04.new(Vector2(rand_range(0, viewport_size.x), rand_range(0, viewport_size.y)), 10)
		$Vehicles.add_child(vehicle)
	
func _process(delta):
	for v in $Vehicles.get_children():
		v.follow($FlowField)

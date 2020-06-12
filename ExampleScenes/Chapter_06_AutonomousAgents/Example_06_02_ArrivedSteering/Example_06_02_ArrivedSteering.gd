extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var target:Vector2

var vehicle = Vehicle_06_02.new(Vector2(100,100), 10)

func _ready():
	target = Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y))
	add_child(vehicle)
	
func _physics_process(delta):
	target = get_global_mouse_position()
	update()
	
	vehicle.arrive(target,delta)
	
func _draw():
	draw_circle(target, 20, Color(0,0,1,0.5))

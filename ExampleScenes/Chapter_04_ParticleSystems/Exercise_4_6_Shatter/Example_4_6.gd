extends Node2D

const PARTICLE_SYSTEM = preload("ParticleSystem_4_6.tscn")


onready var collider = get_node("CollisionShape2D")
onready var viewport_size = get_viewport().get_visible_rect().size
onready var parent = get_parent()

export var extent = 50 

var color1 =  Color(1,0,1,1)
var color2 =  Color(1,1,1,1)
var rect_color = Color(1,1,1)

func _ready():
	extent = rand_range(25, 200)
	var shape = CircleShape2D.new()
	shape.set_radius(extent)
	collider.set_shape(shape)
	
	
	position = Vector2(rand_range(0+extent, viewport_size.x-extent), rand_range(0+extent, viewport_size.y-extent) )
	print(position)

func _process(delta):
	update()

func _gonnaha():
	if extent > 100:
		var particle_system = PARTICLE_SYSTEM.instance()
		particle_system.position = position
		particle_system.cannon_extent = extent
		add_child(particle_system)
		print(get_child_count())



func _on_ShatterArea_mouse_entered():
	rect_color = color1
	print("entered, " , get_global_mouse_position())
	pass # Replace with function body.


func _on_ShatterArea_mouse_exited():
	rect_color = color2
	print("exited, " , get_global_mouse_position())
	pass # Replace with function body.
	
func _draw():
	var rect_pos = Vector2(-extent, -extent)
	var rect_size = Vector2(2*extent,2*extent)
	var rect = Rect2(rect_pos, rect_size)
	draw_rect(rect,rect_color)

func _on_ShatterArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.is_pressed():
		var particle_system = PARTICLE_SYSTEM.instance()
		particle_system.position = position
		particle_system.cannon_extent = extent
		parent.add_child(particle_system)
		print(get_child_count())
		queue_free()

extends Node2D

export (int) var loops = 20
export (float, 0, 1, 0.1) var softness = 0.1
export (float, 0, 1, 0.1) var bias = 0.9
export var exclude_nodes_from_collision_detection = false
export var spacer = 50

export var max_length = 50
export var rest_length = 50
export (float, 0, 1, 0.1) var damping = 0.1
export var stiffness = 20

onready var viewport_size = get_viewport().get_visible_rect().size

func _ready():
	var platform1 = Platform_5_6.new()
	platform1.position = Vector2(viewport_size.x/2, viewport_size.y*0.75) 
	platform1.extents = Vector2(viewport_size.x/4, 10)
	add_child(platform1)

func _process(delta):
	if Input.is_action_just_released("left_mouse"):
		var bouncer = Balls_Connected_Pin_5_6.new()
		bouncer.modulate = Color(0,1,0)
		bouncer.rotation = rand_range(0, 2*PI)
		bouncer.position = get_global_mouse_position()
		bouncer.spacer = spacer
		bouncer.joint.set_exclude_nodes_from_collision(exclude_nodes_from_collision_detection)
		bouncer.joint.set_softness(softness)
		bouncer.joint.set_bias(bias)
		add_child(bouncer)

	if Input.is_action_just_released("right_mouse"):
		var bouncer = Balls_Connected_Spring_5_6.new()
		bouncer.rotation = rand_range(0, 2*PI)
		bouncer.position = get_global_mouse_position()
		bouncer.spacer = spacer
		bouncer.joint.set_rest_length(rest_length)
		bouncer.joint.set_length(max_length)
		bouncer.joint.set_exclude_nodes_from_collision(exclude_nodes_from_collision_detection)
		bouncer.joint.set_damping(damping)
		bouncer.joint.set_stiffness(stiffness)
		bouncer.joint.set_bias(bias)
		add_child(bouncer)

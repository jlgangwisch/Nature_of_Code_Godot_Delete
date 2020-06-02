extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

#var post = Static_Platform_5_7.new()
var platform = Rigid_Platform_5_6.new()
var nail = Static_Platform_5_7.new()
var raindrops = Node2D.new()
var joint = PinJoint2D.new()

export (float, 0, 1, 0.1) var softness = 0.1
export (float, 0, 1, 0.1) var bias = 0.9
export var exclude_nodes_from_collision_detection = true


func _ready():
	add_child(raindrops)
	
	#post.position = Vector2(viewport_size.x/2, viewport_size.y)
	#post.extents = Vector2(10,200)
	
	platform.position =  Vector2(viewport_size.x/2, viewport_size.y-200)
	#platform.position.y -= post.extents.y
	platform.extents = Vector2(200,10)
	
	nail.position = platform.position
	nail.position.x += 100
	nail.extents = Vector2(10,10)
	
	#add_child(post)
	add_child(platform)
	add_child(nail)
	
	joint.position = nail.position
	joint.node_a = nail.get_path()
	joint.node_b = platform.get_path()
	joint.set_bias(bias)
	joint.set_softness(softness)
	joint.set_exclude_nodes_from_collision(exclude_nodes_from_collision_detection)
	add_child(joint)
	


func _process(delta):
	if Input.is_action_pressed("right_mouse"):
		var mouse_pos = get_global_mouse_position()
		var rain = Ball_5_7.new()
		rain.position = Vector2(rand_range(-100+mouse_pos.x, 100+mouse_pos.x), mouse_pos.y)
		raindrops.add_child(rain)
	
	for raindrop in raindrops.get_children():
		if raindrop.position.y > viewport_size.y + 100:
			raindrop.queue_free()
			
	print(raindrops.get_child_count())
	
	if Input.is_action_pressed("left_mouse"):
		platform.apply_torque_impulse(10000)


extends Node2D

export (int) var loops = 20
export (float, 0, 1, 0.1) var softness = 0.1
export (float, 0, 1, 0.1) var bias = 0.9
export var exclude_nodes_from_collision_detection = false
export var spacer = 2

onready var viewport_size = get_viewport().get_visible_rect().size

func _ready():
	var parent = Anchor_5_6.new()
	parent.position = Vector2(viewport_size.x/4,viewport_size.y/2)
	add_child(parent)
	
	for i in range(loops):
		var child = addLoop(parent)
		addLink(parent, child)
		parent = child
		
	var last_anchor = Anchor_5_6.new()
	last_anchor.position = parent.position
	last_anchor.position.x += 2*parent.extents.x + spacer
	print(parent.position)
	add_child(last_anchor)
	addLink(parent, last_anchor)

func _process(delta):
	if Input.is_action_just_released("left_mouse"):
		var rb = Loop_5_6.new()
		rb.position = get_global_mouse_position()
		add_child(rb)

func addLoop(parent):
	var loop = Loop_5_6.new()
	loop.position = parent.position
	loop.position.x += 2*parent.extents.x + spacer
	add_child(loop)
	return loop
	
func addLink(parent, child):
	var pin = PinLink_5_6.new()
	pin.position.x += parent.extents.x + spacer/2
	pin.node_a = parent.get_path()
	pin.node_b = child.get_path()
	pin.set_bias(bias)
	pin.set_softness(softness)
	pin.set_exclude_nodes_from_collision(exclude_nodes_from_collision_detection)
	parent.add_child(pin)



extends DampedSpringJoint2D

func _process(delta):
	update()

func _draw():
	var p1 = get_node(node_a).position
	var p2 = get_node(node_b).position
	draw_line(p1, p2, Color(1,0,0))

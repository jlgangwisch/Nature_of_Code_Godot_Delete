extends Node2D

onready var win_size = get_viewport().get_visible_rect().size

var vehicles = 10
var path = Path_e6_10.new()

var p1 = PoolVector2Array([])
var p2 = PoolVector2Array([])
var p3 = PoolVector2Array([])
var p4 = []

var color1 = Color(0,0,0)
var color2 = Color(1,0,0)

export var show_guides = true

var x = 0

func _ready():
	randomize()
	for v in range(vehicles):
		var vh = Vehicle_e06_10.new(Vector2(rand_range(0,win_size.x), rand_range(0, win_size.y)), rand_range(5,15))
		vh.max_force = 1/vh.size
		$Vehicles.add_child(vh)
		p1.append(vh.position)
		p2.append(vh.position)
		p3.append(vh.position)
		p4.append(false)
	add_child(path)

func _process(delta):
	for v in $Vehicles.get_children():
		var p = v.path_follow(path, delta, color2)
		p1[v.get_index()] = p[0]
		p2[v.get_index()] = p[1]
		p3[v.get_index()] = p[2]
		
		if p[2].distance_to(p[0])>path.radius:
			p4[v.get_index()] = true
		else:
			p4[v.get_index()] = false
	
	path.points[1] = Vector2(win_size.x/4, win_size.y/2+(sin(x)*win_size.y/4))
	path.points[2] = Vector2(win_size.x/4*3, win_size.y/2+(cos(x)*win_size.y/4))
	x+=0.01
	update()
	
func _draw():
	
	if show_guides:
		for v in $Vehicles.get_children():
			var v1 = v.position + Vector2(v.size,0).rotated(v.rotation)
			var v2 = p3[v.get_index()]
			if p4[v.get_index()]:
				color2 = Color(0,1,0)
			else:
				color2 = Color(0,0,0)
			# this keeps the line from flashing 
			if v1.distance_to(v2) < 100:
				draw_line(v1, v2, color1)
			draw_line(v2, p1[v.get_index()], color1)
			draw_circle(v2, 3, color1)
			draw_circle(p1[v.get_index()], 3, color1)
			draw_circle(p2[v.get_index()],5, color2)
		

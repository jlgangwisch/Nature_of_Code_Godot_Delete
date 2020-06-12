extends Node2D

class_name Flow_Field_e6_06

onready var viewport_size = get_viewport().get_visible_rect().size

var field
var cols 
var rows 
export var resolution = 32

func _ready():
	cols = viewport_size.x/resolution
	rows = viewport_size.y/resolution
	
	field =[]
	for i in range(cols):
		var f = PoolVector2Array([])
		for j in range(rows):
			var v = Vector2(i*resolution, j*resolution).direction_to(viewport_size/2)
			f.append(v)
		field.append(f)
	print(field[0][0])

func _process(delta):
	for i in range(cols):
		for j in range(rows):
			field[i][j] = Vector2(i*resolution, j*resolution).direction_to(get_global_mouse_position())
	update()
	
func lookup(looking):
	var column = int(clamp(looking.x/resolution, 0, cols-1))
	var row = int(clamp(looking.y/resolution,0,rows-1))
	return field[column][row].get()
	
func _draw():
	var r = resolution/2-1
	for i in range(cols):
		for j in range(rows):
			var v0 = Vector2.ZERO + Vector2(i*resolution, j*resolution) + Vector2(resolution/2,resolution/2)
			var v1 = v0 - (field[i][j] * r)
			var v3 = v0 + (field[i][j] * r)
			var v2 = v0 + (Vector2(field[i][j].y, -field[i][j].x) *r/2)
			var v4 = v0 - (Vector2(field[i][j].y, -field[i][j].x) *r/2)
			draw_line(v1, v3, Color(1,1,1,0.5))

			draw_colored_polygon(PoolVector2Array([v2, v3, v4]),Color(1,1,1,0.5))

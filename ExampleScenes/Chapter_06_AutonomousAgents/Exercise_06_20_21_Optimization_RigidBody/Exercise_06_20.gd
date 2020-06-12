extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var flock_size =500
var grid = []
var resolution =100
var rows
var columns

func _ready():
#	for i in range(flock_size):
#		var r_pos = Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y))
#		var b = Boid_e06_20.new(r_pos, 10)
#		$Flock.add_child(b)
	
	for i in range(flock_size):
		var r_pos = Vector2(rand_range(0, viewport_size.x), rand_range(0,viewport_size.y))
		var b = Boid_e06_21.new(r_pos, 10)
		$Flock.add_child(b)
		
		columns = int(viewport_size.x / resolution) +1
		rows = int(viewport_size.y / resolution) + 1
	for i in columns:
		grid.append([])
		for j in range(rows):
			grid[i].append([])
	print (columns)
	print (rows)
	
func _process(delta):
	for i in range(columns):
		for j in range(rows):
			grid[i][j].clear()

	for b in $Flock.get_children():
		var col = int(b.position.x / resolution) - 1
		var row = int(b.position.y / resolution) - 1
		grid[col][row].append(b)

#
	for b in $Flock.get_children():
		var col = int(b.position.x / resolution) - 1
		var row = int(b.position.y / resolution) - 1
		b.flock(grid[col][row])
	


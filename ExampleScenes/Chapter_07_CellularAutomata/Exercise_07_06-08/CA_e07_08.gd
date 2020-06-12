#right click to start/pause
#left click to draw cells
#down arrow randomizes board

extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var width = viewport_size.x/columns
onready var rows = viewport_size.y/width +1

var columns =128

var board0 = []
var board1 = []
var paused = true
var is_board0 = true
var b0
var b1
func _ready():
	for i in range (columns):
		board0.append([])
	
		for j in range (rows):
			board0[i].append(0)
	#can't just array1 = array2, that creates a situation where you are still referencing the same objects.
	board1 = board0.duplicate(true)
	b0 = board0
	b1 = board1


func _process(delta):
	if is_board0:
		b0 = board0
		b1 = board1
	
	else:
		b0 = board1
		b1 = board0
	
	if not paused:
		generate()
	
	if Input.is_action_just_released("ui_down"):
		rand_board()
	
	if Input.is_action_pressed("left_mouse"):
		
		var mouse_cell = get_global_mouse_position()/width
		if mouse_cell.x < int(columns) && mouse_cell.y < (rows):
				b0[mouse_cell.x][mouse_cell.y] = 1
				b1[mouse_cell.x][mouse_cell.y] = 1	
	if Input.is_action_just_released("right_mouse"):
		paused = !paused
	
	update()


func rand_board():
	for i in range(columns):
		for j in range(rows):
			board1[i][j] = randi() % 2
	board0 = board1.duplicate(true)

func generate():
	
	for x in range(columns):
		for y in range(rows):

			var living_neighbors = 0
			
			
			
			var n = [-1,0,1]

			for i in n:
				for j in n:
					var u = wrapi(x + i, 0, columns)
					var v = wrapi(y + j, 0, rows)
					living_neighbors += b0[u][v]
			
			living_neighbors -= board0[x][y]
			
			if (b0[x][y] == 1) && living_neighbors <2:
				b1[x][y] = 0
			elif (b0[x][y] == 1) && living_neighbors >3:
				b1[x][y] = 0
			elif (b0[x][y] == 0) && living_neighbors == 3:
				b1[x][y] = 1
			else:
				b1[x][y] = b0[x][y]
			
	#print (is_board0)
	is_board0 = !is_board0

func _draw():

	var size = Vector2(width,width)
	for i in range(board0.size()):
		for j in range (board0[i].size()):
			var color = Color (0,0,0)
			if paused:
				color = Color (0.5,0.5,0.5)
			if b0[i][j] == 1:
				color = Color (1,1,1)
			
			var pos = Vector2(width * i, j*width)
			draw_rect(Rect2(pos, size), color)

#right click to start/pause
#left click to draw cells

extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var width = viewport_size.x/columns
onready var rows = viewport_size.y/width +1

var columns =64

var board0 = []
var board1 = []
var paused = true

func _ready():
	for i in range (columns):
		board0.append([])
	
		for j in range (rows):
			board0[i].append(0)
	#can't just array1 = array2, that creates a situation where you are still referencing the same objects.
	board1 = board0.duplicate(true)


func _process(delta):
	
	if not paused:
		generate()
	
	if Input.is_action_pressed("left_mouse"):
		
		var mouse_cell = get_global_mouse_position()/width
		if mouse_cell.x < int(columns) && mouse_cell.y < (rows):
			board0[mouse_cell.x][mouse_cell.y] = 1
		
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
					living_neighbors += board0[u][v]
					
			living_neighbors -= board0[x][y]
			
			if (board0[x][y] == 1) && living_neighbors <2:
				board1[x][y] = 0
			elif (board0[x][y] == 1) && living_neighbors >3:
				board1[x][y] = 0
			elif (board0[x][y] == 0) && living_neighbors == 3:
				board1[x][y] = 1
			else:
				board1[x][y] = board0[x][y]
	board0 = board1.duplicate(true)

func _draw():

	var size = Vector2(width,width)
	for i in range(board0.size()):
		for j in range (board0[i].size()):
			var color = Color (0,0,0)
			if paused:
				color = Color (0.5,0.5,0.5)
			if board0[i][j] == 1:
				color = Color (1,1,1)
			var pos = Vector2(width * i, j*width)
			draw_rect(Rect2(pos, size), color)

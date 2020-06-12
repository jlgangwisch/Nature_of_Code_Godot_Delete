extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var width = viewport_size.x/columns
onready var rows = viewport_size.y/width +1

var columns =1024

var board0 = []
var board1 = []

func _ready():
	for i in range (columns):
		board0.append([])
	
		for j in range (rows):
			board0[i].append(0)
	#can't just array1 = array2, that creates a situation where you are still referencing the same objects.
	board1 = board0.duplicate(true)

	#print(board1)
func _process(delta):
	if Input.is_action_just_released("left_mouse"):
		rand_board()
		update()
		
	if Input.is_action_pressed("right_mouse"):
		generate()
		update()

func rand_board():
	for i in range(columns):
		for j in range(rows):
			board1[i][j] = randi() % 2
	board0 = board1.duplicate(true)

func generate():
	
	for x in range(columns-1):
		if x == 0 :
			pass

		for y in range(rows-1):
			if y == 0:
				pass
			var living_neighbors = 0
			var n = [-1,0,1]
			
			for i in n:
				for j in n:
					living_neighbors += board0[x+i][y+j]
			
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
			if board0[i][j] == 1:
				color = Color (1,1,1)
			var pos = Vector2(width * i, j*width)
			draw_rect(Rect2(pos, size), color)

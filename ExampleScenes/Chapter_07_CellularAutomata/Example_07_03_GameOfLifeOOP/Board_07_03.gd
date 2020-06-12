extends Node2D

#right click to start/pause
#left click to draw cells
#down arrow randomizes board
onready var viewport_size = get_viewport().get_visible_rect().size
onready var width = viewport_size.x/columns
onready var rows = viewport_size.y/width +1

var columns =128

var board = []

var paused = true

func _ready():
	set_z_index(2)
	for i in range (columns):
		board.append([])
	
		for j in range (rows):
			var c = Cell_07_03.new()
			c.set_z_as_relative(false)
			c.set_z_index(1)
			c.size = width
			c.position = Vector2(i*width, j*width)
			add_child(c)
			board[i].append(c)


func _process(delta):

	if not paused:
		generate()
	
	if Input.is_action_just_released("ui_down"):
		rand_board()
	
	if Input.is_action_pressed("left_mouse"):
		
		var mouse_cell = get_global_mouse_position()/width
		if mouse_cell.x < int(columns) && mouse_cell.y < (rows):
				board[mouse_cell.x][mouse_cell.y].cur_state = 1
				board[mouse_cell.x][mouse_cell.y].prev_state = 1	
	if Input.is_action_just_released("right_mouse"):
		paused = !paused
	
	update()


func rand_board():
	for i in range(columns):
		for j in range(rows):
			board[i][j].cur_state = randi() % 2


func generate():
	
	for x in range(columns):
		for y in range(rows):

			var living_neighbors = 0
			var n = [-1,0,1]

			for i in n:
				for j in n:
					var u = wrapi(x + i, 0, columns)
					var v = wrapi(y + j, 0, rows)
					living_neighbors += board[u][v].prev_state
			
			living_neighbors -= board[x][y].prev_state
			
			if (board[x][y].prev_state == 1) && living_neighbors <2:
				board[x][y].cur_state = 0
			elif (board[x][y].prev_state == 1) && living_neighbors >3:
				board[x][y].cur_state = 0
			elif (board[x][y].prev_state == 0) && living_neighbors == 3:
				board[x][y].cur_state = 1
			else:
				board[x][y].cur_state = board[x][y].prev_state
			

func _draw():
	if paused:
		draw_rect(Rect2(Vector2(0,0),viewport_size), Color(0.5,0.5,0.5,0.5))

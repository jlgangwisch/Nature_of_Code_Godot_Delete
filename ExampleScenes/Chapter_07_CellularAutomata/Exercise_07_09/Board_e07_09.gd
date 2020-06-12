extends Node2D

#right click to start/pause
#left click to draw cells
#down arrow randomizes board
onready var viewport_size = get_viewport().get_visible_rect().size

var w =5
var h = sin(deg2rad(60))*w
var columns
var rows

var board = []

var paused = false

func _ready():
	
	
	set_z_index(2)
	
	columns = viewport_size.x/int(w*3) +2
	rows = viewport_size.y/int(h) +2
	
	
	for i in range (columns):
		board.append([])
	
		for j in range (rows):
			var c = HexCell_e07_09.new()
			c.set_z_as_relative(false)
			c.set_z_index(1)
			c.size = w-1
			if j % 2 == 0:
				c.position = Vector2((i)*w*3, (j)*h)
			else:
				c.position = Vector2(((i)*w*3)+w+(h/2)+(w*.067), (j)*h)
			#c.label.text = "c: " + str(i) +", " + "r: "+ str(j)
			add_child(c)
			board[i].append(c)


func _process(delta):

	if not paused:
		generate()
	
	if Input.is_action_just_released("ui_down"):
		rand_board()
	

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
			var c
			var r
			if y % 2 == 0:
				c = [-1,0]
			else:
				c = [1,0]
			#if board[x][y].cur_state == 1:
			for i in c:
				match i:
					-1 : r =[-1,1]
					0: r = [-2,-1,1,2]
					1 : r =[-1,1,] 
				for j in r:
					var u = wrapi(x + i, 0, columns)
					var v = wrapi(y + j, 0, rows)
					living_neighbors += board[u][v].prev_state

			#living_neighbors -= board[x][y].prev_state

			if (board[x][y].prev_state == 1) && living_neighbors <2:
				board[x][y].cur_state = 0
			elif (board[x][y].prev_state == 1) && living_neighbors >2:
				board[x][y].cur_state = 0
			elif (board[x][y].prev_state == 0) && living_neighbors ==2:
				board[x][y].cur_state = 1
			else:
				board[x][y].cur_state = board[x][y].prev_state

			

func _draw():
	if paused:
		draw_rect(Rect2(Vector2(0,0),viewport_size), Color(0.5,0.5,0.5,0.5))

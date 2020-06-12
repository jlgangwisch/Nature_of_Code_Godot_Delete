extends Node2D

class_name Cell_07_01

onready var viewport_size = get_viewport().get_visible_rect().size
onready var width = viewport_size.x/num_cells
onready var height = viewport_size.y/width

var num_cells = 256
var cells = []

var ruleset = []
var generation = 0
var new = true
var framecount = 0

func _ready():
	ruleset = [0,1,0,1,1,0,1,0]
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_NEVER)
	for i in range(num_cells):
		cells.append(0)
	cells[cells.size()/2] = 1
	
	#fills with random 0/1
#	for i in range(num_cells):
#		var cell = false
#		var r1 = rand_range(0,1)
#		if r1 >0.5 :
#			cell = true
#		cells.append(cell)


func _process(delta):
	#for some reason it won't draw the first frame
	if framecount < 5:
		update()
		framecount += 1
		pass
	else:
		update()
		generate()


func generate():
	
	var new_cells = []
	#ignore edges, fill first and last
	new_cells.append(0)
	for i in range(cells.size()):
		if i != 0 && i != cells.size()-1:
			var l = cells[i-1]
			var m = cells[i]
			var r = cells[i+1]
#			#print(i ,": " , l, ", ", m, ", " , r)
#			print(i ,": " , rules(l,m,r))
			new_cells.append(rules(l,m,r))
	new_cells.append(0)

	cells = new_cells
	generation += 1
	print(cells)

func rules(left,middle,right):
	var s = str(left) + str(middle) + str(right)
	var index = bin2dec(int(s))
	return ruleset[index]

#used instead of parsing strings
func bin2dec(var binary_value):
	var decimal_value = 0
	var count = 0
	var temp
	while(binary_value != 0):
		temp = binary_value % 10
		binary_value /= 10
		decimal_value += temp * pow(2, count)
		count += 1
	return decimal_value
		
func _draw():
	
	if framecount < 5:
		draw_rect(Rect2(Vector2(0,0), viewport_size), Color(0.5,0.5,0.5))
	
	var size = Vector2(width-1,width-1)
	for i in range (cells.size()):
		var color = Color (0,0,0)
		if cells[i] == 1:
			color = Color (1,1,1)
		var pos = Vector2(width * i, generation*width)
		draw_rect(Rect2(pos, size), color)
	

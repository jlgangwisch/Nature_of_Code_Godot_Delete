extends Node2D

class_name Cell_07_03

var cur_state = 0
var prev_state = 0
var size
var color = Color(0,0,0)

func _process(delta):
	update()
	
func _draw():
	
	if prev_state == 0 && cur_state == 1:
		color = Color(0,0,1)
	elif prev_state == 1 && cur_state == 0:
		color = Color(1,0,0)
	elif cur_state == 1:
		color = Color(1,1,1)
	else:
		color = Color(0,0,0)
	draw_rect(Rect2(Vector2(0,0), Vector2(size,size)), color)
	#draw_circle(Vector2(0,0), size/2, color)
	prev_state = cur_state

extends Area2D

class_name HexCell_e07_09

var cur_state = 0
var prev_state = 0
var size =10
var color = Color(0,0,0)
var xoff
var yoff
var v_array = PoolVector2Array([])
var label = Label.new()
func _ready():
	
	add_child(label)

	set_pickable(true)
	connect("input_event", self, "_on_input_event")

	xoff = size/2
	yoff = sin(deg2rad(60))*size
	
	v_array.append(Vector2(0,yoff)- Vector2(xoff, yoff))
	v_array.append(Vector2(xoff,0)- Vector2(xoff, yoff))
	v_array.append(Vector2(xoff+size,0)- Vector2(xoff, yoff))
	v_array.append(Vector2(2*size, yoff)- Vector2(xoff, yoff))
	v_array.append(Vector2(xoff+size, 2*yoff)- Vector2(xoff, yoff))
	v_array.append(Vector2(xoff, 2*yoff)- Vector2(xoff, yoff))
	v_array.append(Vector2(0,yoff))

	var c = CollisionPolygon2D.new()

	c.set_polygon(v_array)
	add_child(c)

func _process(delta):
	update()
	
func _draw():
	
	if cur_state ==1:
		color = Color(1,1,1)
	else:
		color = Color(0,0,0, 0.25)
		
	if prev_state == 0 && cur_state == 1:
		color = Color(0,0,1)
	elif prev_state == 1 && cur_state == 0:
		color = Color(1,0,0)
	elif cur_state == 2:
		color = Color(0,1,0)

	#draw_rect(Rect2(Vector2(0,0), Vector2(size,size)), color)
	#draw_circle(Vector2(0,0), size/2, color)
	draw_colored_polygon(v_array,color)
	prev_state = cur_state




func _on_input_event(viewport, event, shape_idx):
	print(cur_state)
	if Input.is_action_pressed("left_mouse"):
		cur_state = 1
		prev_state = 1
	print (event)


extends Node2D

var anchor_pos = Vector2()
export var length = 100
#elasticity = k
export var elasticity = 0.2

func _ready():
	anchor_pos = position
	
func spring_connect(Bob):
	var force = Bob.position - anchor_pos
	var d = force.length()
	var stretch = d - length
	force = force.normalized()
	force = -force * elasticity * stretch
	Bob.apply_force(force)
	
func _draw():
	var anchor_size = Vector2(20,20)
	draw_rect(Rect2(position-(anchor_size/2), anchor_size), Color(1,1,1))
	


func _process(delta):
	update()

#this is the answer to Exercise 3_15
func constrain_length(Bob, min_length, max_length):
	var dir = Bob.position - anchor_pos
	var d = dir.length()
	
	if d < min_length:
		dir = dir.normalized()
		dir = dir * min_length
		Bob.position = anchor_pos + dir
		Bob.velocity = Bob.velocity * 0
		
	elif d > max_length:
		dir = dir.normalized()
		dir = dir * max_length
		Bob.position = anchor_pos + dir
		Bob.velocity = Bob.velocity * 0
		

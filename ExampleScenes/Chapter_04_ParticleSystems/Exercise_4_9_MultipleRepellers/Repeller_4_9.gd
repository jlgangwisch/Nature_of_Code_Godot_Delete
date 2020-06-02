extends Node2D

class_name Repeller_e4_9

var radius = 50
var strength = 10

func _ready():
	strength = radius 

func _physics_process(delta):
	update()
	
func _draw():
	draw_circle(Vector2(0,0), radius, Color(1,1,1))

func repel(particle):
	var dir = position - particle.position
	#print (dir)
	var d = dir.length()
	d = clamp(d, 50, 100)
	dir = dir.normalized()
	var force = -1 * strength / (d * d)
	dir *= force 
	return dir

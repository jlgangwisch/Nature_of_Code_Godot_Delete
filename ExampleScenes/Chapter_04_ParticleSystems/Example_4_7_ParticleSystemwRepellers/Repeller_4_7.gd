extends Node2D

class_name Repeller_4_7

var radius = 50
var strength = 100

func _physics_process(delta):
	update()
	
func _draw():
	draw_circle(Vector2(0,0), radius, Color(1,1,1))

func repel(particle):
	var dir = position - particle.position
	var d = dir.length()
	d = clamp(d, 100, 1000)
	dir = dir.normalized()
	var force = -1 * strength / (d * d)
	dir *= force 
	return dir

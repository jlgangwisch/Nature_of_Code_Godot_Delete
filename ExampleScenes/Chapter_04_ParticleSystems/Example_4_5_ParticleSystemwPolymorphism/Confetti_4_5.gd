extends "Particle_4_5.gd"

class_name Confetti_4_5



func _physics_process(delta):
	#var angle = my_map(position.x, 0, viewport_size.x, 0, 4*PI)
	var angle = atan2(velocity.y, velocity.x) 
	rotation = angle
	pass

	
func confetti_shape():
	var extent = 4
	var rect_pos = Vector2(-extent, -extent)
	var rect_size = Vector2(2*extent, 2*extent)
	var rect = Rect2(rect_pos, rect_size)
	draw_rect(rect, Color(color.r,color.g,color.b, lifetime))

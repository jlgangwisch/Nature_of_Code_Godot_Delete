extends "Particle_4_6.gd"

class_name Confetti_4_6



func _physics_process(delta):
	#var angle = my_map(position.x, 0, viewport_size.x, 0, 4*PI)
	var angle = atan2(velocity.y, velocity.x) 
	rotation = angle
	pass

	
func confetti_shape():
	var extent = size/2
	var rect_pos = Vector2(-extent, -extent)
	var rect_size = Vector2(size, extent)
	var rect = Rect2(rect_pos, rect_size)
	draw_rect(rect, Color(color.r,color.g,color.b, lifetime))

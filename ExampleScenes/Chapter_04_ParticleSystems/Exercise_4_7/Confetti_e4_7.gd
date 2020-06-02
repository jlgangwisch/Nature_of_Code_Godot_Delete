extends "Particle_e4_7.gd"

class_name Confetti_e4_7



func _physics_process(delta):
	#var angle = my_map(position.x, 0, viewport_size.x, 0, 4*PI)
	var angle = atan2(velocity.y, velocity.x)
	rotation = angle

	
func confetti_shape():
	var extent = 4
	var rect_pos = Vector2(-extent, -extent)
	var rect_size = Vector2(2*extent, 2*extent)
	var rect = Rect2(rect_pos, rect_size)
	draw_rect(rect, Color(1,1,1))

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

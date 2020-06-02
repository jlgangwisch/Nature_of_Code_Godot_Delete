extends "Confetti_4_6.gd"

class_name Triconfetti_4_6

	
func confetti_shape():
	var v1 = Vector2(-size, size)
	var v2 = Vector2(size, 0)
	var v3 = Vector2(-size, -size)
	var shape = PoolVector2Array([v1, v2, v3])
	draw_colored_polygon(shape,Color(color.r,color.g,color.b,lifetime))
	

extends CollisionShape2D

func _draw():
	draw_circle(Vector2(0,0), shape.radius, Color(1,1,1,0.25))

extends Node2D
export var circle_radius = 5
export var circle_color = Color(0,0,0)

func _draw():
	draw_circle(Vector2(position.x-30, position.y),circle_radius,circle_color)
	draw_rect(Rect2(position.x-30, position.y-1, 60, 2), circle_color, true)
	draw_circle(Vector2(position.x+30, position.y), circle_radius,circle_color)
	
	

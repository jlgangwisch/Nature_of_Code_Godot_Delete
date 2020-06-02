extends Node2D


export var circle_radius = 10.0
export var circle_color = Color(0,0,0)

func _draw():
	draw_circle(position, circle_radius*get_parent().mass,circle_color)
	

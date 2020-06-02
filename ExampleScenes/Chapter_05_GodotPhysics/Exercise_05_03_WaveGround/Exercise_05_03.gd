extends Node2D

onready var ball = preload("Ball_Rigid_Body2d_5_3.tscn")
onready var viewport_size = get_viewport().get_visible_rect().size

var num_balls = 50

func _ready():
	for num in num_balls:
		var ball_instance = ball.instance()
		ball_instance.position = Vector2(rand_range(0,viewport_size.x), 0)
		add_child(ball_instance)

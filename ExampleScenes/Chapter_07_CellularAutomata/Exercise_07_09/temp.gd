extends Node2D

#right click to start/pause
#left click to draw cells
#down arrow randomizes board
onready var viewport_size = get_viewport().get_visible_rect().size

var w = 32
var h = sin(deg2rad(60))*w
var columns
var rows

var board = []

var paused = true

func _ready():
	set_z_index(2)
	
	var c = HexCell_e07_09.new()
	c.size = w
	c.position = Vector2(100,100)
	add_child(c)

extends StaticBody2D

onready var collider = get_node("CollisionShape2D")

var size = Vector2(0,0)
var color = Color(0,1,1)
var n_color = Color(0,1,1)
var h_color = Color (0.5,0.5,0.5)

func _ready():
	size = get_parent().anchor_size
	collider.shape.extents = size

func _process(delta):
	update()

func _draw():
	draw_rect(Rect2(-size, size*2), color)


func _on_Anchor_5_10_mouse_entered():
	print("entered")
	color = h_color


func _on_Anchor_5_10_mouse_exited():
	print("exited")
	color = n_color

extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var rope = get_node("Verlet_Rope")

func _ready():
	#position = Vector2(viewport_size.x/2, viewport_size.y/4)
	rope.end_pin = false

func _process(delta):
	update()

func _draw():
	var size = 10
	var rect_pos = rope.pos[0] - Vector2(size, size)
	var bob_pos = rope.pos[rope.count-1]
	draw_rect(Rect2(rect_pos,Vector2(size*2,size*2)), Color(1,0,0))
	draw_circle(bob_pos, size, Color(0,1,0))

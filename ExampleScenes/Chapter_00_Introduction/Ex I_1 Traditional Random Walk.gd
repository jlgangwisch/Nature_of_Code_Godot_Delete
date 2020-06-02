extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size

var rand_generate = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#generate new seed
	randomize()

	#set Node2D position to center of screen
	position = Vector2(viewport_size.x/2, viewport_size.y/2)
	
	#These make sure the background doesn't redraw and erase the line
	#viewport.set_transparent_background(true)
	viewport.set_clear_mode(Viewport.CLEAR_MODE_NEVER)

func _draw():
	#There doesn't seem to be anything like point, so this will draw a white dot at the size of 1 pixel
	var point_position = PoolVector2Array( [Vector2(0, 0)] ) # or just the inner array, necessary if using typed GDScript (3.1)
	var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
	draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	trad_random_walk()

	
func trad_random_walk():
			#generate random integer between 1-4
	var my_integer = rand_generate.randi_range(1,4)
	
	match my_integer:
		1:
			position.x += 1
		2: 
			position.x -= 1
		3: 
			position.y += 1
		4: 
			position.y -= 1
	
	print(my_integer)

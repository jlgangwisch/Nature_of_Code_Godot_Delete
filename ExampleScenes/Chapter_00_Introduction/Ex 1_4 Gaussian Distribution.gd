extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size

var rand_generate = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#create new random seed
	randomize()

	#set Node2D position to center of screen
	
	#These make sure the background doesn't redraw and erase the line
	#viewport.set_transparent_background(true)
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)


func _draw():
	#There doesn't seem to be anything like point, so this will draw a white dot at the size of 1 pixel
	var circle_position = position # or just the inner array, necessary if using typed GDScript (3.1)
	var circle_radius = 5
	var circle_color = Color(1, 1, 1, 0.1) # same as above
	draw_circle(circle_position, circle_radius, circle_color)
	# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	#Generates a normally-distributed pseudo-random number, using Box-Muller transform with the specified mean and a standard deviation. This is also called Gaussian distribution.
	var standard_deviation = 60
	var mean = viewport_size.x / 2
	position.x = rand_generate.randfn(mean,standard_deviation)
	position.y = viewport_size.y /2
	print(position)

extends Node2D

onready var viewport = get_viewport()
onready var viewport_size = get_viewport().get_visible_rect().size


# Instantiate
var noise = OpenSimplexNoise.new()
var tx = 0
var ty = 10000

# Called when the node enters the scene tree for the first time.
func _ready():
	#configure OpenSimplex Noise
	noise_configure()

	#set Node2D position to center of screen
	position = Vector2(viewport_size.x/2, viewport_size.y/2)
	
	#These make sure the background doesn't redraw and erase the line
	#viewport.set_transparent_background(true)
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)


func _draw():
	#There doesn't seem to be anything like point, so this will draw a white dot at the size of 1 pixel
	var circle_position = position # or just the inner array, necessary if using typed GDScript (3.1)
	var circle_radius = 5
	var circle_color = Color(1, 1, 1) # same as above
	draw_circle(circle_position, circle_radius, circle_color)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#There is no built in map function in this version.  See my_map() below
	position.x = my_map(noise.get_noise_1d(tx), 0, 1, 0, viewport_size.x)
	position.y = my_map(noise.get_noise_1d(ty), 0, 1, 0, viewport_size.y)
	print (position)
	tx += 0.01
	ty += 0.01

func noise_configure():
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output


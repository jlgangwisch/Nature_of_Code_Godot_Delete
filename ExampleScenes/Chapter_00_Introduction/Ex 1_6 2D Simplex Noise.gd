#This effect may be achieved most easily by using a noise texture.  This is the long way of drawing one, but I couldn't figure out how to animate a noise texture.  Look at Ex 1_9 for an example using slightly less complicated way.
extends Sprite

var noise = OpenSimplexNoise.new()
var time_x = 0
var time_y = 10000
var offset_x = 0
var offset_y = 0

var brightness = 0.1
var my_image = Image.new()
var my_texture = ImageTexture.new()

onready var viewport_size = get_viewport().get_visible_rect().size

func _ready():
	noise_configure()
	my_image.create(viewport_size.x, viewport_size.y, false, Image.FORMAT_RGB8)
	draw_noise_to_image(my_image)
	my_texture.create_from_image(my_image)
	texture = my_texture
	
	position = Vector2(viewport_size.x/2, viewport_size.y/2)
	#texture.set_size_override(viewport_size)
	#position.x = my_map(noise.get_noise_1d(tx), 0, 1, 0, viewport_size.x)
	

func _process(delta):
	pass
	
	
func noise_configure():
	noise.seed = 1
	noise.octaves = 4
	noise.period = 20
	noise.persistence = 0.8

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output
	
func draw_noise_to_image(function_image):
	function_image.lock()
	var period_x = 0
	for x in viewport_size.x:
		var period_y = 0
		for y in viewport_size.y:
			brightness = my_map(noise.get_noise_2d(period_x,period_y), -1, 1, 0, 1)
			function_image.set_pixel(x,y,Color(brightness, brightness, brightness))
			period_y += 0.1
		period_x += 0.1
	function_image.unlock()

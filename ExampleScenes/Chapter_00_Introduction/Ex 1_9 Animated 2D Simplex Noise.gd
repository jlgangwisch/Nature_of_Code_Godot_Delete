#There has got to be a better way to do this with a noise texture
extends Node2D

var noise = OpenSimplexNoise.new()
var time_x = 0
var time_y = 10000
var time_z = 1000
var offset_x = 0
var offset_y = 0

var brightness = 0.1

export var cellsize = 5;

onready var viewport_size = get_viewport().get_visible_rect().size

func _ready():
	noise_configure()

	
	#position = Vector2(viewport_size.x/2, viewport_size.y/2)
	#texture.set_size_override(viewport_size)
	#position.x = my_map(noise.get_noise_1d(tx), 0, 1, 0, viewport_size.x)
	

func _process(delta):
	

	#time_x += 1
	#time_y += 1
	time_z += 0.1
	update()
	
	
func noise_configure():
	noise.seed = 1
	noise.octaves = 4
	noise.period = 20
	noise.persistence = 0.8

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

func _draw():
	for x in int(viewport_size.x/cellsize):
		for y in int(viewport_size.y/cellsize):
			var val = noise.get_noise_3d(x, y, time_z) * 0.5 + 0.5
			var color = Color(1.0-val/2.0, 0.5-val/2.0, val/4.0)
			var r = Rect2(x*cellsize, y*cellsize, cellsize, cellsize)
			draw_rect(r, color)

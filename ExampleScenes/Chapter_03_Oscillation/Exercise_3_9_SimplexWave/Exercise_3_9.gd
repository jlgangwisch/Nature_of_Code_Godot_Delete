extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var start_angle = 0.0
var angle = 0.0
var aVelocity = 0.1
var amplitude = 100

# Instantiate
var noise = OpenSimplexNoise.new()
var tx = 0
var ty = 10000

func _ready():
	noise_configure()



func _process(delta):
	ty = tx
	update()
	tx += 0.01





func _draw():
	
	for pixel in viewport_size.x/24+1:
		var y = my_map(noise.get_noise_1d(ty), -1, 1, 0, viewport_size.y)
		var x = pixel * 24
		
		#var point_position = PoolVector2Array( [Vector2(x, y)] ) # or just the inner array, necessary if using typed GDScript (3.1)
		var position = Vector2(x,y)
		var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
		#draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
		draw_circle(position, 24, Color(1,1,1,0.5))
		#angle += aVelocity
		ty += 1
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

func noise_configure():
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8

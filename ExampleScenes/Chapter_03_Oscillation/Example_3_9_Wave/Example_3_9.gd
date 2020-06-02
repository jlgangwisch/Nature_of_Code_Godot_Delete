extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var start_angle = 0.0
var angle = 0.0
var aVelocity = 0.1
var amplitude = 100

func _ready():
	pass # Replace with function body.


func _process(delta):
	angle = start_angle
	update()
	start_angle += 0.01





func _draw():
	
	for pixel in viewport_size.x/24+1:
		var y = my_map(sin(angle), -1, 1, 0, viewport_size.y)
		var x = pixel * 24
		
		#var point_position = PoolVector2Array( [Vector2(x, y)] ) # or just the inner array, necessary if using typed GDScript (3.1)
		var position = Vector2(x,y)
		var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
		#draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
		draw_circle(position, 24, Color(1,1,1,0.5))
		angle += aVelocity
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

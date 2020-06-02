extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var start_angle = 0.0
var angle = 0.0
export var oscillation_speed = 0.01
export var frequency = 0.1
export var amplitude = 100
export var period = 10
export var proximity = 24
export var starting_pos = Vector2(0,0)

func _ready():
	pass # Replace with function body.


func _process(delta):
	angle = start_angle
	update()
	start_angle -= oscillation_speed





func _draw():
	
	for segment in period/proximity:
		var y = my_map(sin(angle), -1, 1, -amplitude, amplitude)
		var x = segment * proximity
		var position = Vector2(x,y) + starting_pos
		var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
		#draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
		draw_circle(position, 24, Color(1,1,1,0.5))
		angle += frequency
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

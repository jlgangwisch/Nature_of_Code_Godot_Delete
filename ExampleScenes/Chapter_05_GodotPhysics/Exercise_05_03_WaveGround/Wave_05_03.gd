extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size

var start_angle = 0.0
var angle = 0.0
export var oscillation_speed = 0.01
export var frequency = 0.1
var amplitude = 100
var period = 1024
export var proximity = 25
var starting_pos = Vector2(0,0)

func _ready():
	starting_pos = Vector2(0, viewport_size.y/2)
	period = viewport_size.x
	amplitude = viewport_size.y/2
	

func _process(delta):
	angle = start_angle
	update()
	start_angle -= oscillation_speed





func _draw():
	var final_wave_array = PoolVector2Array([])
	
	#wave 1
	for segment in period/proximity+1:
		var y = my_map(sin(angle), -1, 1, -amplitude/4, amplitude/4)
		var x = segment * proximity
		var position = Vector2(x,y) + starting_pos
		final_wave_array.append(position)
		var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
		#draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
		draw_circle(position, 24, Color(1,0,0,0.5))
		angle += 0.2
	
	#wave2
	for segment in period/proximity+1:
		var y = my_map(sin(angle), -1, 1, -amplitude/4, amplitude/4)
		var x = segment * proximity
		var position = Vector2(x,y) +starting_pos
		final_wave_array[segment] += Vector2(0, y)
		var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
		#draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
		draw_circle(position, 24, Color(0,1,0,0.5))
		angle += 0.1
	
	#wave3
	for segment in period/proximity+1:
		var y = my_map(sin(angle), -1, 1, -amplitude/4, amplitude/4)
		var x = segment * proximity
		var position = Vector2(x,y) + starting_pos
		final_wave_array[segment] += Vector2(0, y)
		var point_color = PoolColorArray( [Color(1, 1, 1)] ) # same as above
		#draw_primitive(point_position, point_color, PoolVector2Array()) # third argument is UV, disregarded here, used to map texture
		draw_circle(position, 24, Color(0,0,1,0.5))
		angle += 0.4
	
	for segment in final_wave_array.size():
		var position = final_wave_array[segment] 
		#draw_circle(position, 24, Color(1,1,1,0.5))
	
	final_wave_array.append(viewport_size)
	final_wave_array.append(Vector2(0,viewport_size.y))
	draw_colored_polygon(final_wave_array,Color(1,1,1))
	get_node("CollisionPolygon2D").set_polygon(final_wave_array)
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

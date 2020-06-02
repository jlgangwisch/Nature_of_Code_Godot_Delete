#This solution is heavily lifted from Agnis Nezvers Aldins: https://github.com/nezvers/Godot_Public_Examples
#There is also an excellent demonstration of Verlet soft bodies in Godot Con 2019 by John Meadows: https://youtu.be/I2OW-kx3u_4?t=2600

extends Node2D
#How many particles
export (float) var length = 30
export (float) var constrain = 1
export (Vector2) var gravity = Vector2(0,9.8)
export (float) var friction = 0.9

#these pins mean they will not move
export (bool) var start_pin = true
export (bool) var end_pin = true

#where each particle is 
var pos: PoolVector2Array
#where each particle last was
var pos_ex: PoolVector2Array
var count: int

func _ready():
	count = get_count(length)
	resize_arrays()
	init_position()
	pass
	
func _physics_process(delta):
	if Input.is_action_pressed("left_mouse"):
		pos[0] = get_global_mouse_position()
		pos_ex[0] = get_global_mouse_position()
	elif Input.is_action_pressed("right_mouse"):
		pos[count-1] = get_global_mouse_position()
		pos_ex[count-1] = get_global_mouse_position()
	
	update_points(delta)
	update_distance()
	update_distance()	#Repeat to get tighter rope
	#update_distance()
	update()

	
func get_count(distance: float):
	var new_count = ceil(distance/constrain)
	return new_count

func resize_arrays():
	pos.resize(count)
	pos_ex.resize(count)
	
func init_position():
	for i in range(count):
		pos[i] = position + Vector2(constrain * i, 0)
		pos_ex[i] = position + Vector2(constrain * i, 0)
	position = Vector2.ZERO
	
#this update points is the verlet integration. There is a commented out version that more simply shows it below from John Meadow
func update_points(delta):
	for i in range (count):
				# not first and last || first if not pinned || last if not pinned
		if (i!=0 && i!=count-1) || (i==0 && !start_pin) || (i==count-1 && !end_pin):
			var vec2 = (pos[i] - pos_ex[i]) * friction
			pos_ex[i] = pos[i]
			pos[i] += vec2 + (gravity * delta)
		
		
#func verlet(delta):
#	var new_position = 2*position - previous_position
#	new_position += force * pow(delta,2.0)
#	previous_position = position
#	position = new_position
#	velocity = (position-previous_position)/ delta

func update_distance():
	for i in range (count):
		if i == count-1:
			return
		var vec2 = pos[i+1] - pos[i]
		#var distance = vec2.length()
		var distance = pos[i].distance_to(pos[i+1])
		var difference = constrain-distance
		var percent = difference / distance
#
		if i==0:
			if start_pin:
				pos[i+1] +=vec2 * percent
			else:
				pos[i] -=vec2 * (percent/2)
				pos[i+1] +=vec2 * (percent/2)
		elif i == count-1:
			pass
		else:
			if i+1 == count -1 && end_pin:
				pos[i] -=vec2 * (percent)
			else:
				pos[i] -=vec2 * (percent/2)
				pos[i+1] +=vec2 * (percent/2)

func _draw():
	draw_polyline(pos, Color(1,1,1))
	#for p in pos:
	#	draw_circle(p,5,Color(0,0,1,0.5))

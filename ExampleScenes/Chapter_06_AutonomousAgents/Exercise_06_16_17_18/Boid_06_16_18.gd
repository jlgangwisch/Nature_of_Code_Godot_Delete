extends Area2D

class_name Boid_e06_16_18

onready var viewport_size = get_viewport().get_visible_rect().size

var velocity : = Vector2(rand_range(-1,1), rand_range(-1,1))
var acceleration : Vector2


export var size : float

var target: Vector2
var mass = 1
var polygon : PoolVector2Array
var color = Color(1,0,0,0.5)

var lookahead = 25
var vision_angle = PI/4

var noise = OpenSimplexNoise.new()
var t_x = 0
var t_y = 10000
var t_z = 100000000
var t_u = 1000000000000
var t_v = 10000000000000000

var sep_weight = 1.5
var coh_weight = 1.0
var align_weight = 1.0
var max_speed : float = 4
var max_force : float = 0.1



func noise_configure():
	noise.seed = 1
	noise.octaves = 4
	noise.period = 20
	noise.persistence = 0.8


func _init(_position:Vector2, _size:float):
	position = _position
	size = _size
	noise_configure()
	
func _ready():
	var collider = CollisionPolygon2D.new()
	var v1 = Vector2(-size,-size)
	var v2 = Vector2(size,0)
	var v3 = Vector2(-size,size)
	polygon = PoolVector2Array([v1,v2,v3])
	collider.set_polygon(polygon)
	add_child(collider)
	
func _process(delta):
	#06_18
#	sep_weight += noise.get_noise_1d(t_u)*0.1
#	coh_weight += noise.get_noise_1d(t_v)*0.1
#	align_weight += noise.get_noise_1d(t_x)*0.1
#	max_speed += noise.get_noise_1d(t_y)*0.1
#	max_force += noise.get_noise_1d(t_z)*0.1
#	t_u += 0.1
#	t_v += 0.1
#	t_x += 0.1
#	t_y += 0.1
#	t_z += 0.1
	
	velocity += acceleration
	velocity = velocity.clamped(max_speed)
	position += velocity
	acceleration *= 0

	rotation = velocity.angle()
	
	check_edges()
	update()
	
func flock(boids):
	
	var separation = separate(boids)
	var align = align(boids)
	var cohesion = cohere(boids)
	#A not very graceful implementation of Flake's rule 0617
	unblock(boids)
	
	#06 16:
	var seek_mouse = seek(get_global_mouse_position())
	
	separation *= sep_weight
	align *= align_weight* 0.05
	cohesion *= coh_weight*0.05

	
	apply_force(separation)
	apply_force(align)
	apply_force(cohesion)
	apply_force(seek_mouse)



func align(boids):
	var neighbor_distance = 50
	var count = 0
	var sum = Vector2(0,0)
	for i in boids:
		
		var d = position.distance_to(i.position)
		#Exercise_06_15
		if (d>0) && (d<neighbor_distance) && (position.angle_to(i.position)<vision_angle):
		#Example_06_09
		#if (d>0) && (d<neighbor_distance):
			sum += i.velocity
			count+=1
	if count>0:
		sum /= count
		sum = sum.normalized()*max_speed
		var steer = sum - velocity
		steer = steer.clamped(max_force)
		return steer
	else:
		return Vector2(0,0)

func unblock(boids):
	var neighbor_distance = 50
	var count = 0
	var sum = Vector2(0,0)
	for i in boids:
		
		var d = position.distance_to(i.position)
		#Exercise_06_15
		if (d>0) && (d<neighbor_distance)  && (position.angle_to(i.position)<vision_angle):
		#Example_06_09
		#if (d>0) && (d<neighbor_distance):
			position += Vector2(i.velocity.y, -i.velocity.x).normalized()
	

func separate(vehicles):
	var desired_separation = size * 4
	var sum = Vector2()
	var count = 0
	for v in vehicles:
		var d = position.distance_to(v.position)
		if (d>0) && (d < desired_separation):
			var diff = position - v.position
			diff = diff.normalized()
			diff /= d
			sum += diff
			count += 1
	if (count>0):
		sum /= count
		sum = sum.normalized()
		sum *= max_speed
		var steer = sum - velocity
		steer = steer.clamped(max_force)
		return steer
	else:
		return Vector2(0,0)

func cohere(boids):
	var desired_separation = size * size
	var sum = Vector2()
	var count = 0
	for b in boids:
		var d = position.distance_to(b.position)
		if (d>0) && (d < desired_separation):
			sum += b.position
			count +=1
	if (count>0):
		sum /= count
		return seek(sum)
	else:
		return Vector2(0,0)

func seek(_target:Vector2):
	var desired = _target - position
	desired = desired.normalized()
	desired *= max_speed * 100
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(max_force)
	#apply_force(steer)
	return steer

func apply_force(force:Vector2):
	var f = force
	f /= mass
	acceleration += f

func check_edges():
	if position.x < 0-size:
		position.x += viewport_size.x+size
	elif position.x > viewport_size.x+size:
		position.x -= viewport_size.x+size
	elif position.y < 0-size:
		position.y += viewport_size.y+size
	elif position.y > viewport_size.y+size:
		position.y -= viewport_size.y+size

func _draw():
	draw_colored_polygon(polygon, color)
	#draw_circle(Vector2(0,0), size, Color(1,1,1,0.5))
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

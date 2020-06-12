extends Area2D

class_name Boid_06_09

onready var viewport_size = get_viewport().get_visible_rect().size

var velocity : = Vector2(rand_range(-1,1), rand_range(-1,1))
var acceleration : Vector2

export var max_speed : float = 4
export var max_force : float = 0.1
export var size : float

var target: Vector2
var mass = 1
var polygon : PoolVector2Array
var color = Color(1,0,0,0.5)

var lookahead = 25
var vision_angle = PI/4

func _init(_position:Vector2, _size:float):
	position = _position
	size = _size
	
func _ready():
	var collider = CollisionPolygon2D.new()
	var v1 = Vector2(-size,-size)
	var v2 = Vector2(size,0)
	var v3 = Vector2(-size,size)
	polygon = PoolVector2Array([v1,v2,v3])
	collider.set_polygon(polygon)
	add_child(collider)
	
func _process(delta):
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
	
	separation *= 1.5
	align *= 1
	cohesion *= 1
	
	apply_force(separation)
	apply_force(align)
	apply_force(cohesion)

func align(boids):
	var neighbor_distance = 50
	var count = 0
	var sum = Vector2(0,0)
	for i in boids:
		
		var d = position.distance_to(i.position)
		#Exercise_06_15
		if (d>0) && (d<neighbor_distance) && (position.angle_to(i.position) > -vision_angle) && (position.angle_to(i.position)<vision_angle):
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

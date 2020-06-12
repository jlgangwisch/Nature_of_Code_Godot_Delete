extends Area2D

class_name Vehicle_06_08

onready var viewport_size = get_viewport().get_visible_rect().size

var velocity : = Vector2(1,1)
var acceleration : Vector2

export var max_speed : float = 4
export var max_force : float = 0.1
export var size : float
export var show_guides = true

var target: Vector2
var mass = 1
var polygon : PoolVector2Array
var color = Color(1,0,0,0.5)

var lookahead = 25

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
	
	var theta = velocity.angle()
	rotation = theta
	
	check_edges()
	update()
	
func apply_behaviours(vehicles):
	
	var separate = separate(vehicles)
	var seek = seek(get_global_mouse_position())
	
	separate *= 1.5
	seek *= 0.5
	
	apply_force(separate)
	apply_force(seek)
	
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
		#apply_force(steer)
		return steer
	else:
		return Vector2(0,0)

func cohere(vehicles):
	var desired_separation = size * size
	var sum = Vector2()
	var count = 0
	for v in vehicles:
		var d = position.distance_to(v.position)
		if (d>0) && (d < desired_separation):
			var diff = v.position - position
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
		#apply_force(steer)
	
func seek(_target:Vector2):
	var desired = _target - position
	desired = desired.normalized()
	desired *= max_speed * 100
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(max_force)
	#apply_force(steer)
	return steer

func field_follow(flow):
	var desired = flow.lookup(position)
	desired *= max_speed
	var steer = desired - velocity
	steer = steer.clamped(max_force)
	#apply_force(steer)


	
func path_follow(path, delta, color):
	var predict = velocity
	predict = predict.normalized()
	predict *= lookahead
	var predict_loc = position + predict
	
	var target
	var normal
	var goal_dist = 1000000000000000
	for i in range(path.points.size()):
		var a = path.points[i]
		var b = path.points[(i+1)%path.points.size()]
		var normal_point = get_normal(a,b, predict_loc)
		
		var dir = b-a
		
		if (normal_point.x < min(a.x, b.x) || normal_point.x > max(a.x,b.x) || normal_point.y < min(a.y,b.y) || normal_point.y > max(a.y, b.y)):
			normal_point = b
			a = path.points[(i+1)%path.points.size()]
			b = path.points[(i+2)%path.points.size()]
			dir = b - a
			
		var distance = predict_loc.distance_to(normal_point)
		
		if (distance < goal_dist):
			goal_dist = distance
			normal = normal_point
			
			dir = dir.normalized()
			dir *= lookahead
			target = normal
			target += dir
		

	
	if goal_dist > path.radius:
		seek(target)
		pass
	return PoolVector2Array([normal, target, predict_loc])

	
func get_normal(i, j, veh_predict_loc):
	var a = veh_predict_loc - i
	var b = j - i
	#var theta = a.angle_to(b)
	#var d = a.length() * cos(theta)
	b = b.normalized()
	b *= a.dot(b)
	#b *= d
	var normal_point = i + b
	return normal_point
	
func wall_avoidance(_wall_distance, delta):
	var desired = velocity
	var m_speed = max_speed * delta * 100000
	if position.x < _wall_distance:
		desired = Vector2(m_speed, velocity.y)
	elif position.x > viewport_size.x - _wall_distance:
		desired = Vector2(-m_speed, velocity.y)
	if position.y < _wall_distance:
		desired = Vector2(velocity.x, m_speed)
	elif position.y > viewport_size.y - _wall_distance:
		desired = Vector2(velocity.x, -m_speed)
	var steer = desired - velocity
	steer = steer.clamped(max_force*2)
	#apply_force(steer)

func flee(_target:Vector2, delta):
	var desired = position - _target
	desired = desired.normalized()
	desired *= max_speed * delta * 100
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(max_force)
	#apply_force(steer)

func apply_force(force:Vector2):
	var f = force
	f /= mass
	acceleration += f

func arrive(target, delta):
	var desired = target - position
	var d = desired.length()
	desired = desired.normalized()
	if d<100 :
		var m = my_map(d, 0, 100, 0, max_speed)
		desired *= m
	else:
		desired *= max_speed * delta * 100
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(max_force)
	#apply_force(steer)
	
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
	#draw_colored_polygon(polygon, color)
	draw_circle(Vector2(0,0), size, Color(1,1,1,0.5))
	
func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

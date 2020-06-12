extends Area2D

class_name Vehicle_06_04

onready var viewport_size = get_viewport().get_visible_rect().size

var velocity : = Vector2(1,1)
var acceleration : Vector2

export var max_speed : float = 4
export var max_force : float = 0.1
export var size : float
var target: Vector2
var mass = 1
var polygon : PoolVector2Array
var color = Color(1,0,0,0.5)

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
	
func seek(_target:Vector2, delta):
	var desired = _target - position
	desired = desired.normalized()
	desired *= max_speed * delta * 100
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(max_force)
	apply_force(steer)

func follow(flow):
	var desired = flow.lookup(position)
	desired *= max_speed
	var steer = desired - velocity
	steer = steer.clamped(max_force)
	apply_force(steer)
	
	
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
	apply_force(steer)

func flee(_target:Vector2, delta):
	var desired = position - _target
	desired = desired.normalized()
	desired *= max_speed * delta * 100
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(max_force)
	apply_force(steer)

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
	apply_force(steer)
	
func check_edges():
	if position.x < 0:
		position.x += viewport_size.x
	elif position.x > viewport_size.x:
		position.x -= viewport_size.x
	elif position.y < 0:
		position.y += viewport_size.y
	elif position.y > viewport_size.y:
		position.y -= viewport_size.y

func _draw():
	draw_colored_polygon(polygon, color)

func my_map(input, minInput, maxInput, minOutput, maxOutput):
	#explained here: https://victorkarp.wordpress.com/2019/10/01/godot-engine-how-to-remap-a-range-of-numbers-to-another-range-visually-explained/
	var output = ( (input - minInput) / (maxInput - minInput) * (maxOutput - minOutput) + minOutput )
	return output

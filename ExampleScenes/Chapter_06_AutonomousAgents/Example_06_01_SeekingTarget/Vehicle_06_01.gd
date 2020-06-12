extends Area2D

class_name Vehicle_06_01

var velocity : Vector2
var acceleration : Vector2

export var max_speed : float = 4
export var max_force : float = 0.1
export var size : float
var target: Vector2
var mass = 1
var polygon : PoolVector2Array

func _init(_position:Vector2, _size:float, _target:Vector2):
	position = _position
	size = _size
	target = _target
	
func _ready():
	var collider = CollisionPolygon2D.new()
	var v1 = Vector2(-size,-size)
	var v2 = Vector2(size,0)
	var v3 = Vector2(-size,size)
	polygon = PoolVector2Array([v1,v2,v3])
	collider.set_polygon(polygon)
	add_child(collider)

func _physics_process(delta):
	seek(get_parent().target)
	velocity += acceleration
	velocity = velocity.clamped(max_speed)
	position += velocity
	acceleration *= 0
	
	var theta = velocity.angle()
	rotation = theta
	
func seek(_target:Vector2):
	var desired = _target - position
	desired = desired.normalized()
	desired *= max_speed
	var steer: Vector2 = desired - velocity
	steer = steer.clamped(max_force)
	apply_force(steer)

func apply_force(force:Vector2):
	var f = force
	f /= mass
	acceleration += f


func _draw():
	draw_colored_polygon(polygon, Color(1,0,0,0.5))

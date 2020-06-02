extends Node2D

class_name Distance_Constraint_5_12

export(NodePath) var node_path_1:NodePath setget set_node_1
export(NodePath) var node_path_2:NodePath setget set_node_2

var point_1:PointMass_5_12
var point_2:PointMass_5_12

var mass_ratio_1 :float = 0
var mass_ratio_2 :float = 0

var constrain_vector  := Vector2( 0.0, 0.0 )
var rest_length       := 200
var compress_stiffness:= 0.1
var stretch_stiffness := 0.1

var sprite_size = Vector2(4,128)


func initialize( node_1:PointMass_5_12, node_2:PointMass_5_12, _rest_length: float):
	point_1 = node_1
	point_2 = node_2
	constrain_vector = point_2.position - point_1.position #- d
	#Turn this off for force directed graph. Turn back on for a structured entity.
	#rest_length = constrain_vector.length()
	rest_length = _rest_length
	
func _ready():
	if !point_1:
		point_1 = get_node(node_path_1) as PointMass_5_12
	if !point_2:
		point_2 = get_node(node_path_2) as PointMass_5_12
	point_1.add_neighbor(point_2)
	point_2.add_neighbor(point_1)
	mass_ratio_1 = point_1.mass / (point_1.mass + point_2.mass)
	mass_ratio_2 = point_2.mass / (point_1.mass + point_2.mass)


func _physics_process(_delta):
	if point_1 and point_2 :
		position            = 0.5 * ( point_1.position + point_2.position )
		
		var relation_vector := point_1.position - point_2.position
		
		rotation            = atan2( relation_vector.x, -relation_vector.y )
		scale.y             = max(10, relation_vector.length()) / sprite_size.y
		scale.x             = sprite_size.x / clamp( relation_vector.length(), sprite_size.x, sprite_size.y )
	update()



func set_node_1(value:NodePath):
	node_path_1 = value
	
	
func set_node_2(value:NodePath):
	node_path_2 = value

func _draw():
	draw_rect(Rect2(-sprite_size/2, sprite_size), Color(0,0,1))

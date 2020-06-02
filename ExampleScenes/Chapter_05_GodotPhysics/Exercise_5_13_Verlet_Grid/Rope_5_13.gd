extends Position_Based_Dynamics_5_13

class_name Rope_5_13

export var verticles:int = 10
export var verticles_distance:float = 10.0

var line_vertices = PoolVector2Array([])

func _ready():
#	if !Engine.is_editor_hint():
	generate_rope_body( verticles, verticles_distance )

func _physics_process(delta):
	
#	if Input.is_action_pressed("left_mouse"):
#		$verticles.get_child(0).position = get_global_mouse_position()
#
#	elif Input.is_action_pressed("right_mouse"):
#		$verticles.get_child(verticles-1).position = get_global_mouse_position()
#		$verticles.get_child(verticles-1).modulate = Color(0,0,1)
#
		
	for node in $verticles.get_children():
		if node.is_static != true:
			#external_force.x = abs(sin(wind + node.position.y/100.0) + abs(sin((wind+ node.position.y/100.0)*3.67))) * 1000
			aplly_external_forces( node, delta )
			apply_velocity_damping( node, delta, damping )
			calculate_projected_position( node, delta )

	solve_distance_constraint( 4, 1.0 )
	solve_floor_collision_constraint( 700.0 - position.y )
	update_vertex_position( delta )
	#update_polyline_verticles()
	
	update()

#func update_polyline_verticles ():
#	var i:int = 0
#	for node in $verticles.get_children():
#		line_vertices[i] = node.position
#		i += 1
		
func generate_rope_body( verticles:int = 2, separation:int = 10 ):
	for i in range(verticles):
		var new_position = Vector2( 0, separation * i  )
		if i == 0:
			add_vertex( new_position, true )
		else:
			add_vertex( new_position, false )
		line_vertices.append(new_position)

	for i in range(verticles-1):
		add_spring( $verticles.get_child_count() -i -1, $verticles.get_child_count() -i -2, compress_stiffness, stretch_stiffness )
#
#func _draw():
#	draw_polyline(line_vertices, Color(0,0,1))

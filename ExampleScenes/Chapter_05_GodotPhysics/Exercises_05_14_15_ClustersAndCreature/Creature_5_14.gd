extends Position_Based_Dynamics_5_14

class_name Creature_5_14

export var verticles:int = 10
export var verticles_distance:float = 10.0

export var diameter = 10

func _ready():
	generate_cluster_body( verticles, verticles_distance )
	
func _physics_process(delta):

#	delta *= 0.01
	for node in $verticles.get_children():
		if node.is_static != true:
			#external_force.x = abs(sin(wind + node.global_position.x/1000.0) + abs(sin((wind+ node.global_position.x/1000.0)*3.67))) * 1000
			apply_external_forces( node, delta )
			apply_velocity_damping( node, delta, damping )
			calculate_projected_position( node, delta )

	solve_floor_collision_constraint( 500.0 - position.y )
	solve_distance_constraint( 2, 1 )
	update_vertex_position( delta )
	
func generate_cluster_body(nodes:int, size:float):
	for i in range(nodes):
		add_vertex(Vector2(rand_range(100,200), rand_range(100,200)), false, 1.0 )
	
	for i in range(nodes):
		for j in range(nodes-1-i):
			add_spring($verticles.get_child_count() - nodes + i, $verticles.get_child_count() - nodes + i + j + 1, compress_stiffness, stretch_stiffness )

		#func add_spring( node_index_1, node_index_2, new_compress, new_stretch  )->void:
func generate_cloth_body( nodes:int, size:float )->void:
	for i in range(nodes):
		for j in range(nodes):
			if i == 0 && (j == 0 || j == nodes-1):
				add_vertex(  Vector2( j, i ) * size, true , 1.0)
			else:
				add_vertex(  Vector2( j, i ) * size, false , 1.0)
	var total_nodes = nodes*nodes
	for i in range(nodes):
		for j in range(nodes):
			if j < nodes-1:
				add_spring($verticles.get_child_count() - total_nodes + i * nodes + j, $verticles.get_child_count() - total_nodes + i*nodes + (j+1), compress_stiffness, stretch_stiffness )
			if i < nodes-1:
				add_spring($verticles.get_child_count() - total_nodes + i * nodes + j, $verticles.get_child_count() - total_nodes + (i+1)*nodes + j, compress_stiffness, stretch_stiffness )


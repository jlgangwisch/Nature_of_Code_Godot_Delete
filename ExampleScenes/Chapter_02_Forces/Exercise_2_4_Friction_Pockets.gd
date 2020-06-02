extends Node2D

onready var viewport_size = get_viewport().get_visible_rect().size
onready var movers = get_node("Movers")

export var gravity = Vector2(0,0.01)
export var wall_aversion = Vector2(0,0)


func _ready():
	randomize()
	for mover in movers.get_children():
		mover.position = Vector2(rand_range(0,viewport_size.x),viewport_size.y/2)
		mover.mass = rand_range(1,10)
		
		
func _physics_process(delta):
	for mover in movers.get_children():
		mover.apply_force(gravity*mover.mass)
		process_wall_aversion(mover.position)
		mover.apply_force(wall_aversion)
		if mover.is_in_friction:
			var friction = process_friction(mover.velocity)
			mover.apply_force(friction)
		elif mover.is_in_zoom:
			var friction = process_friction(mover.velocity) * -1
			mover.apply_force(friction)

	
func process_friction(obj_velocity):
	var friction = obj_velocity * -1
	friction = friction.normalized()
	var coefficient = .01
	var normal = 1
	friction = friction * normal * coefficient
	return friction
	
func process_wall_aversion(position):
	var right_wall_aversion = (position.x / viewport_size.x) *-0.01
	var left_wall_aversion = 1/position.x 
	wall_aversion = Vector2(right_wall_aversion + left_wall_aversion,0)
	#print(wall_aversion)


func _on_FrictionArea_area_entered(area):
	area.is_in_friction = true
	print(area.is_in_friction)
	pass # Replace with function body.


func _on_FrictionArea_area_exited(area):
	area.is_in_friction = false
	pass # Replace with function body.


func _on_ZoomArea_area_entered(area):
	area.is_in_zoom = true
	pass # Replace with function body.


func _on_ZoomArea_area_exited(area):
	area.is_in_zoom = false
	pass # Replace with function body.

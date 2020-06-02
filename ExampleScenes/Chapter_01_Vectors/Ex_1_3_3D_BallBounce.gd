extends Spatial

#onready var viewport_size = get_viewport().get_visible_rect().size

export var velocity = Vector3(2.5,5,4)
export var circle_radius = 10.0
export var circle_color = Color(1.0,1.0,1.0)
export var box_extents = 50

func _physics_process(delta):
	
	translate(velocity)

	if translation.x < -box_extents or translation.x > box_extents:
		velocity.x *= -1
	if translation.y < -box_extents or translation.y > box_extents:
		velocity.y *= -1
	if translation.z < -box_extents or translation.z > box_extents:
		velocity.z *= -1

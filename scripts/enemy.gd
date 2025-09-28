extends Node2D


const SPEED := 35
var direction := -1

@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight


func _process(delta: float) -> void:
	# check whether enemy needs to change direction
	if ray_cast_left.is_colliding() or ray_cast_right.is_colliding():
		direction *= -1
		$AnimatedSprite2D.flip_h = true if direction > 0 else false
	
	# move the enemy in the direction at a set speed
	self.position.x += direction * SPEED * delta
	

extends Sprite2D

@onready var timer: Timer = $Timer
var direction = 1

const SPEED = 800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !direction:
		direction = 1
	timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(1, 0) * delta * SPEED * direction
	


func _on_timer_timeout() -> void:
	queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()

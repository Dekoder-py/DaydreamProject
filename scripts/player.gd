extends CharacterBody2D

@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var shoot_timer: Timer = $ShootTimer
@onready var death_sound: AudioStreamPlayer = $DeathSound

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var health: float = 5 
var can_shoot := true

func shoot():
	damage_self(0.5)
	can_shoot = false
	shoot_timer.start()
	
	
func damage_self(damage: float):
	health -= damage
	print("Health: ", health)
	if health <= 0:
		death_sound.play()
		get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and !is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		
	# handle shoot
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_shoot_timer_timeout() -> void:
	can_shoot = true

extends CharacterBody2D

@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var shoot_timer: Timer = $ShootTimer
@onready var death_sound: AudioStreamPlayer = $DeathSound
const BULLET = preload("uid://cicicymixxwo5")



const HEART_HALF = preload("uid://cmjuvnk6nc62u")
const HEART_EMPTY = preload("uid://btvkx1io5xfbf")

var facing = 1

const SPEED = 400.0
const JUMP_VELOCITY = -500.0
var health: float = 5 
var can_shoot := true


func shoot(direction):
	var bullet = BULLET.instantiate()
	bullet.position = position + Vector2(150 * direction, 0)
	bullet.direction = direction
	get_parent().add_child(bullet)
	
	damage_self(0.5)
	can_shoot = false
	shoot_timer.start()
	
	
func damage_self(damage: float):
	health -= damage
	print("Health: ", health)
	
	if health == 4:
		$"../HUD/HeartFive".texture = HEART_EMPTY
	if health == 3:
		$"../HUD/HeartFour".texture = HEART_EMPTY
	if health == 2:
		$"../HUD/HeartThree".texture = HEART_EMPTY
	if health == 1:
		$"../HUD/HeartTwo".texture = HEART_EMPTY
	if health == 0:
		$"../HUD/HeartOne".texture = HEART_EMPTY
	
	
	if health == 4.5:
		$"../HUD/HeartFive".texture = HEART_HALF
	if health == 3.5:
		$"../HUD/HeartFour".texture = HEART_HALF
	if health == 2.5:
		$"../HUD/HeartThree".texture = HEART_HALF
	if health == 1.5:
		$"../HUD/HeartTwo".texture = HEART_HALF	
	if health == 0.5:
		$"../HUD/HeartOne".texture = HEART_HALF	
	
	if health <= 0:
		# Play death sound
		death_sound.play()

		# After sound ends, start a short timer before reloadinng
		await death_sound.finished
		get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
	
	
	# handle shoot
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot(facing)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		facing = direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func _on_shoot_timer_timeout() -> void:
	can_shoot = true

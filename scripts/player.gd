extends CharacterBody2D

@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var shoot_timer: Timer = $ShootTimer
@onready var death_sound: AudioStreamPlayer = $DeathSound
const BULLET = preload("uid://cicicymixxwo5")

@onready var heart_five = $"../HUD/HeartFive"
@onready var heart_four = $"../HUD/HeartFour"
@onready var heart_three = $"../HUD/HeartThree"
@onready var heart_two = $"../HUD/HeartTwo"
@onready var heart_one = $"../HUD/HeartOne"

const HEART_HALF = preload("uid://cmjuvnk6nc62u")
const HEART_EMPTY = preload("uid://btvkx1io5xfbf")
const HEART_FULL = preload("uid://be6lh627frqkl")

var facing = 1

const SPEED = 400.0
const JUMP_VELOCITY = -500.0
var health: float = 5 
var can_shoot := true


func shoot(direction):
	var bullet = BULLET.instantiate()
	bullet.position = position + Vector2(80 * direction, 0)
	bullet.direction = direction
	get_parent().add_child(bullet)
	
	damage_self(0.5)
	can_shoot = false
	shoot_timer.start()
	
	
func damage_self(damage: float):
	health -= damage
	print("Health: ", health)
	
	if health == 4:
		heart_five.texture = HEART_EMPTY
	if health == 3:
		heart_four.texture = HEART_EMPTY
	if health == 2:
		heart_three.texture = HEART_EMPTY
	if health == 1:
		heart_two.texture = HEART_EMPTY
	if health == 0:
		heart_one.texture = HEART_EMPTY
	
	
	if health == 4.5:
		heart_five.texture = HEART_HALF
	if health == 3.5:
		heart_four.texture = HEART_HALF
	if health == 2.5:
		heart_three.texture = HEART_HALF
	if health == 1.5:
		heart_two.texture = HEART_HALF	
	if health == 0.5:
		heart_one.texture = HEART_HALF	
	
	if health <= 0:
		# Play death sound
		death_sound.play()
		await get_tree().create_timer(death_sound.stream.get_length()).timeout
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")


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
		
	if facing == -1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

	move_and_slide()



func _on_shoot_timer_timeout() -> void:
	can_shoot = true
	
func heal(amount: float) -> void:
	health += amount
	if health > 5:
		health = 5
	
	if health == 5:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_FULL
		heart_three.texture = HEART_FULL
		heart_four.texture = HEART_FULL
		heart_five.texture = HEART_FULL
	if health == 4.5:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_FULL
		heart_three.texture = HEART_FULL
		heart_four.texture = HEART_FULL
		heart_five.texture = HEART_HALF
	if health == 4:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_FULL
		heart_three.texture = HEART_FULL
		heart_four.texture = HEART_FULL
		heart_five.texture = HEART_EMPTY
	if health == 3.5:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_FULL
		heart_three.texture = HEART_FULL
		heart_four.texture = HEART_HALF
		heart_five.texture = HEART_EMPTY
	if health == 3:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_FULL
		heart_three.texture = HEART_FULL
		heart_four.texture = HEART_EMPTY
		heart_five.texture = HEART_EMPTY
	if health == 2.5:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_FULL
		heart_three.texture = HEART_HALF
		heart_four.texture = HEART_EMPTY
		heart_five.texture = HEART_EMPTY
	if health == 2:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_FULL
		heart_three.texture = HEART_EMPTY
		heart_four.texture = HEART_EMPTY
		heart_five.texture = HEART_EMPTY
	if health == 1.5:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_HALF
		heart_three.texture = HEART_EMPTY
		heart_four.texture = HEART_EMPTY
		heart_five.texture = HEART_EMPTY
	if health == 1:
		heart_one.texture = HEART_FULL
		heart_two.texture = HEART_EMPTY
		heart_three.texture = HEART_EMPTY
		heart_four.texture = HEART_EMPTY
		heart_five.texture = HEART_EMPTY
	if health == 0.5:
		heart_one.texture = HEART_HALF
		heart_two.texture = HEART_EMPTY
		heart_three.texture = HEART_EMPTY
		heart_four.texture = HEART_EMPTY
		heart_five.texture = HEART_EMPTY
	if health == 0:
		heart_one.texture = HEART_EMPTY
		heart_two.texture = HEART_EMPTY
		heart_three.texture = HEART_EMPTY
		heart_four.texture = HEART_EMPTY
		heart_five.texture = HEART_EMPTY
	
	
	print("Health: ", health)

	


func _on_enemy_detector_2000_body_entered(_body: Node2D) -> void:
	damage_self(1)

func _on_heart_picked_up():
	print("Healing now, sig received")
	heal(1)

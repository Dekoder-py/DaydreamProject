extends Area2D

@onready var timer: Timer = $Timer
@onready var death_sound: AudioStreamPlayer = $DeathSound


func _on_body_entered(body: Node2D) -> void:
	death_sound.play()
	await death_sound.finished
	get_tree().reload_current_scene()

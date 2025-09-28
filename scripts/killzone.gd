extends Area2D

@onready var timer: Timer = $Timer
@onready var death_sound: AudioStreamPlayer = $DeathSound

signal player_in_zone


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("damage_self"):
		player_in_zone.emit()
	

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_one.tscn")

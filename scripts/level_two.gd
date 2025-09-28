extends Node2D

@onready var killzone: Area2D = $Killzone
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	killzone.player_in_zone.connect(_on_player_killed)


func _on_player_killed():
	for i in range(5):
		player.damage_self(1)

extends Node2D

@onready var game_title: Label = $GameTitle

@onready var button_container: VBoxContainer = $"Button Container"


func get_center(node) -> Vector2:
	return (get_viewport_rect().size - node.size) / 2

func _ready() -> void:
	# center start menu items
	game_title.position = get_center(game_title)
	button_container.position = get_center(button_container)
	
	# move them into the correct y-axis position
	game_title.position.y -= 220
	button_container.position.y -= 100
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

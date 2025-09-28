extends Node2D


@onready var credits_text: Label = $CreditsText
@onready var return_to_main: Button = $ReturnToMain


func get_center(node) -> Vector2:
	return (get_viewport_rect().size - node.size) / 2

func _ready() -> void:
	# center start menu items
	credits_text.position = get_center(credits_text)
	return_to_main.position = get_center(return_to_main)
	
	# move them into the correct y-axis position
	credits_text.position.y -= 120
	return_to_main.position.y += 200
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

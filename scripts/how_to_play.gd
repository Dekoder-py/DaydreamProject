extends Node2D


@onready var instruction_text: Label = $InstructionText
@onready var return_to_main: Button = $ReturnToMain


func get_center(node) -> Vector2:
	return (get_viewport_rect().size - node.size) / 2

func _ready() -> void:
	# center start menu items
	instruction_text.position = get_center(instruction_text)
	return_to_main.position = get_center(return_to_main)
	
	# move them into the correct y-axis position
	instruction_text.position.y -= 120
	return_to_main.position.y += 200
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

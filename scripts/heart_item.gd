extends Area2D

signal heal

func _on_body_entered(body: Node2D) -> void:
	emit_signal("heal")
	print("picked up and sent signal")
	queue_free()
	

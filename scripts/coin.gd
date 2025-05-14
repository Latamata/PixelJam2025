extends Area2D

func _process(delta: float) -> void:
	position.y += 150 * delta

func _on_body_entered(body: Node2D) -> void:
	body.rise_from_dead()
	queue_free()

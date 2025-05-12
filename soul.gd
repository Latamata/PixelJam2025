extends Area2D


@export var speed := 50  # pixels per second

func _process(delta):
	position.x += speed * delta

func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	queue_free()

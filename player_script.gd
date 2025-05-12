extends CharacterBody2D

@export var speed := 100.0  # You can adjust this to your needs

func _physics_process(_delta):
	var direction = 0.0
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1

	velocity.x = direction * speed
	velocity.y = 0  # No vertical movement
	
	move_and_slide()

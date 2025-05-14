extends CharacterBody2D

@export var speed := 100.0  # You can adjust this to your needs
@onready var sense_circle: Area2D = $sense_circle
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	var shape = $sense_circle/CollisionShape2D.shape
	if shape is CircleShape2D:
		shape.radius = 5.0


func _process(_delta):
	var direction = 0.0
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1

	velocity.x = direction * speed
	velocity.y = 0  # No vertical movement
	
	move_and_slide()


func _on_sense_circle_body_entered(body: Node2D) -> void:
	if body.is_in_group("undead"):
		body.sensed_out()

func soul_sense():
	animation_player.play("circle_sense")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "circle_sense":
		animation_player.seek(0.0, true) 
		animation_player.stop()        

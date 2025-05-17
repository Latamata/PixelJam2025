extends CharacterBody2D

signal cooldown_updated(progress : float)

@export var speed := 100.0  # You can adjust this to your needs
@onready var sense_circle: Area2D = $sense_circle
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var sense_on_cooldown = false
var direction := 0.0  # Make direction a member variable

func _input(_event):
	direction = 0.0
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1

func _process(_delta):
	velocity.x = direction * speed
	move_and_slide()

	# Clamp position to left/right edges of screen
	var screen_size = get_viewport_rect().size
	var sprite_size = 32  # Replace with your sprite width if needed

	global_position.x = clamp(global_position.x, sprite_size / 2.0, screen_size.x - sprite_size / 2.0)

func _on_sense_circle_body_entered(body: Node2D) -> void:
	if body.is_in_group("undead") :
		body.sensed_out()
		body.attacking = false


func soul_sense():
	sense_on_cooldown = true
	cooldown_counter = 5.0
	$sense_timer.start()
	animation_player.play("circle_sense")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "circle_sense":
		animation_player.seek(0.0, true) 
		animation_player.stop()        


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('undead'):
		#print('running')
		body.rise_from_dead() 


var max_cooldown = 5.0
var cooldown_counter = 0
func _on_sense_timer_timeout():
	cooldown_counter -= 1.0
	emit_signal("cooldown_updated", cooldown_counter )
	if cooldown_counter <= 0:
		sense_on_cooldown = false
		print("Cooldown finished!")
		$sense_timer.stop()

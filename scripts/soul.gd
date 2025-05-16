extends CharacterBody2D

signal evil_spirit_triggered

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var SPEED := 50  # pixels per second
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D
var boat 
var evil_soul 
var attacking = false 
var rising = false 
var end_of_the_road 

func _process(delta):
	if position.x >= end_of_the_road:
		queue_free()

	if attacking and !rising:
		var target = boat
		var to_target = (target.global_position - global_position).normalized()
		velocity = to_target * SPEED
		rotation = to_target.angle()
		sprite_2d.flip_v = to_target.x < 0
		move_and_slide()

		# Clamp Y so it doesn’t rise above the water
		var water_y_limit = get_tree().current_scene.get_node("water_ovelay").global_position.y
		global_position.y = max(global_position.y, water_y_limit)
	else:
		sprite_2d.flip_v = false
		rotation = 0.0
		position.x += SPEED * delta


func rise_from_dead() -> void:
	rising = true
	if evil_soul: 
		animation_player.play('evil_rise')
	else:
		animation_player.play('rise_up')
	Globals.add_souls(1)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "evil_soul":
		sprite_2d.modulate = Color(1, 1, 1)       # White, or whatever your default is
		point_light_2d.color = Color(1, 1, 1)       # White, or whatever your default is
		point_light_2d.energy = 0.0                # Or your default energy value
	elif anim_name == "rise_up":
		queue_free()
	elif anim_name == "evil_rise":
		emit_signal('evil_spirit_triggered')
		queue_free()

func sensed_out():
	z_index = 1
	if evil_soul:
		animation_player.play('evil_soul')

	await get_tree().create_timer(0.5).timeout  # Wait half a second (adjust if needed)
	z_index = 0

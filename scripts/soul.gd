extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var SPEED := 50  # pixels per second
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D
var boat 
var attacking = false 
var end_of_the_road 

func _process(delta):
	
	#print(position)
	if position.x >= end_of_the_road:
		queue_free()
	if attacking:
		var target = boat
		var to_target = (target.global_position - global_position).normalized()
		velocity = to_target * SPEED
		rotation = to_target.angle()
		sprite_2d.flip_v = to_target.x < 0

		move_and_slide()
	else:
		sprite_2d.flip_v = false
		rotation = 0.0
		position.x += SPEED * delta

func rise_from_dead() -> void:
	animation_player.play('rise_up')
	Globals.add_souls(1)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'rise_up':
		queue_free()

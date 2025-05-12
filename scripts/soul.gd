extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var speed := 50  # pixels per second
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D
var end_of_the_road 

func _ready():
	if sprite_2d.material:
		sprite_2d.material = sprite_2d.material.duplicate()

func _process(delta):
	position.x += speed * delta
	#print(position)
	if position.x >= end_of_the_road:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	animation_player.play('rise_up')
	Globals.add_souls(1)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'rise_up':
		queue_free()

extends Node2D

#-------VARIABLES----------
@onready var coin_scene = preload("res://scenes/coin.tscn")
@onready var soul_scene = preload("res://scenes/soul.tscn")
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var sould_group_node: Node2D = $sould_group_node

#-------FUNCTIONS----------
func _ready() -> void:
	Globals.connect( "UI_signal", _UI_signal )

func _input(event):
	if event.is_action_pressed("ui_accept"):
		toss_a_coin()

func toss_a_coin():
	var coin = coin_scene.instantiate()
	coin.position = player.position  # Spawns at current node's position (e.g. boat)
	get_tree().current_scene.add_child(coin)
	
func spawn_soul():
	var soul = soul_scene.instantiate()
	
	# Get camera boundaries
	var cam_pos = camera_2d.global_position
	var screen_size = get_viewport().get_visible_rect().size
	
	# Spawn just off the left edge
	var spawn_x = cam_pos.x - screen_size.x / 2 - 32  # 32 = padding, adjust if needed

	# Adjust vertical spawn range to cut off the top 25% (you can tweak the 0.25)
	var top_limit = cam_pos.y - screen_size.y / 2 + screen_size.y * 0.25
	var bottom_limit = cam_pos.y + screen_size.y / 2
	var spawn_y = randf_range(top_limit, bottom_limit)
	#print(screen_size)
	soul.end_of_the_road = screen_size.x
	soul.global_position = Vector2(spawn_x, spawn_y)
	sould_group_node.add_child(soul)

func _UI_signal():
	$user_interface.update_UI()

func _on_timer_timeout() -> void:
	spawn_soul()

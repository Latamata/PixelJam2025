extends Node2D

#-------VARIABLES----------
@onready var coin_scene = preload("res://scenes/coin.tscn")
@onready var soul_scene = preload("res://scenes/soul.tscn")
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var soul_group_node: Node2D = $soul_group_node

#-------FUNCTIONS----------
func _ready() -> void:
	Globals.connect( "UI_signal", _UI_signal )

func _input(event):
	if event.is_action_pressed("ui_accept"):
		toss_a_coin()
@onready var water_ovelay: ColorRect = $water_ovelay

func toss_a_coin():
	var coin = coin_scene.instantiate()
	coin.position = player.position  # Spawns at current node's position (e.g. boat)
	get_tree().current_scene.add_child(coin)

func spawn_soul():
	var soul = soul_scene.instantiate()

	# Get camera boundaries
	var cam_pos = camera_2d.global_position
	var screen_size = get_viewport().get_visible_rect().size
	# Spawn just to the left of the water overlay
	var overlay_pos = water_ovelay.get_global_position()
	var spawn_x = overlay_pos.x - 32  # Adjust padding as needed


	# Spawn somewhere between 25% and 100% of screen height
	var top_limit = cam_pos.y - screen_size.y / 2 + screen_size.y * 0.25
	var bottom_limit = cam_pos.y + screen_size.y / 2
	var spawn_y = randf_range(top_limit, bottom_limit)

	# Setup soul
	if evil_water_off:
		soul.attacking = true

	# 🎲 Random chance to be evil — 20% chance (adjust as needed)
	if randf() < 0.2: 
		soul.evil_soul = true
	soul.connect("evil_spirit_triggered", Callable(self, "_on_soul_evil_spirit_triggered"))

	soul.boat = player
	soul.end_of_the_road = screen_size.x
	soul.global_position = Vector2(spawn_x, spawn_y)

	soul_group_node.add_child(soul)


func _UI_signal():
	$user_interface.update_UI()

func _on_timer_timeout() -> void:
	spawn_soul()

var evil_water_off = false
func _on_user_interface_change_color_water() -> void:

	if !evil_water_off:
		$water.material.set_shader_parameter("wave_color", Color(1.0, 0.5, 0.0))
		evil_water_off = true
		$frenzy_timestop.start()
		for entity in soul_group_node.get_children():  # Include all entities
			entity.attacking = true
	else:
		$water.material.set_shader_parameter("wave_color", Color(0.0, 0.8, 1.0))
		evil_water_off = false
		for entity in soul_group_node.get_children():  # Include all entities
			entity.attacking = false
#shader_parameter/wave_color


func _on_user_interface_sense_souls() -> void:
	#print(player.sense_on_cooldown)
	if !player.sense_on_cooldown:
		player.soul_sense()

var frenzy_on_cooldown = false

func _on_soul_evil_spirit_triggered() -> void:
	#print(frenzy_on_cooldown)
	if !evil_water_off and !frenzy_on_cooldown:
		
		_on_user_interface_change_color_water()
		
		
		

func _on_frenzy_timestop_timeout() -> void:
	_on_user_interface_change_color_water()
	frenzy_on_cooldown = true
	$frenzy_balanceCD.start()  # Start cooldown timer

func _on_player_cooldown_updated(progress: float) -> void:
	$user_interface.set_soul_reload_UI(progress)
	

func _on_frenzy_balance_cd_timeout() -> void:
	print('running')
	if frenzy_on_cooldown:
		frenzy_on_cooldown = false

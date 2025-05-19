extends Node

signal UI_signal
var soul_count = 0
const SOUL_LIMIT = 50  # set your desired limit

func add_souls(soul_amount):
	soul_count += soul_amount
	soul_count = max(soul_count, 0)  
	emit_signal('UI_signal')
	if soul_count >= SOUL_LIMIT:
		call_deferred("_change_to_ending_scene")

func _change_to_ending_scene():
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://scenes/ending.tscn")

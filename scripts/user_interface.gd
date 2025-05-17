extends Control

signal change_color_water
signal sense_souls
@onready var soul_count: RichTextLabel = $Control/soul_count
@onready var sense_cooldown: ProgressBar = $helpers/sense_cooldown

func update_UI():
	soul_count.text = str(Globals.soul_count)

func _on_button_button_down() -> void:
	emit_signal('change_color_water')

func _on_soul_sense_button_down() -> void:
	#print('button pressed')
	emit_signal('sense_souls')

func set_soul_reload_UI(progress):
	sense_cooldown.value = sense_cooldown.max_value - progress

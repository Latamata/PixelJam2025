extends Control

signal change_color_water
signal sense_souls
@onready var soul_count: RichTextLabel = $Control/soul_count

func update_UI():
	soul_count.text = str(Globals.soul_count)


func _on_button_button_down() -> void:
	emit_signal('change_color_water')

func _on_soul_sense_button_down() -> void:
	#print('button pressed')
	emit_signal('sense_souls')

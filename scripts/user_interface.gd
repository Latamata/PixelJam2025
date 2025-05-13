extends Control

signal change_color_water
@onready var soul_count: RichTextLabel = $Control/soul_count

func update_UI():
	soul_count.text = str(Globals.soul_count)


func _on_button_button_down() -> void:
	emit_signal('change_color_water')

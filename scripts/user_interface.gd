extends Control

@onready var soul_count: RichTextLabel = $Control/soul_count

func update_UI():
	soul_count.text = str(Globals.soul_count)

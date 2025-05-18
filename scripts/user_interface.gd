extends Control

#signal change_color_water
signal sense_souls
@onready var soul_count: RichTextLabel = $Control/soul_count
@onready var sense_cooldown: ProgressBar = $helpers/sense_cooldown

func _ready() -> void:
	_on_button_button_down()

func update_UI():
	soul_count.text = str(Globals.soul_count)

func _on_button_button_down() -> void:
	show_tut()
	
func _on_soul_sense_button_down() -> void:
	#print('button pressed')
	emit_signal('sense_souls')

func set_soul_reload_UI(progress):
	sense_cooldown.value = sense_cooldown.max_value - progress

func show_tut():
	$tuts.visible = true
	get_tree().paused = true


func _on_exit_tut_button_down() -> void:
	print('runnging')
	$tuts.visible = false
	get_tree().paused = false

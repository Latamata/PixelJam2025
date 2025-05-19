extends Control

#signal change_color_water
signal sense_souls
@onready var soul_count: RichTextLabel = $Control/soul_count
@onready var sense_cooldown: ProgressBar = $helpers/sense_cooldown

func _ready() -> void:
	_on_button_button_down()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_exit_tut_button_down()

func update_UI():
	soul_count.text = str(Globals.soul_count)

func _on_button_button_down() -> void:
	show_tut()
	
func _on_soul_sense_button_down() -> void:
	if soul_progress >= sense_cooldown.max_value:
		emit_signal("sense_souls")
		soul_progress = 0.0
		set_soul_reload_UI(soul_progress)


var soul_progress := 0.0

func add_soul_progress(amount: float) -> void:
	if soul_progress >= sense_cooldown.max_value:
		return  # Already full, don't add more
	
	soul_progress = clamp(soul_progress + amount, 0.0, sense_cooldown.max_value)
	set_soul_reload_UI(soul_progress)


func set_soul_reload_UI(progress):
	sense_cooldown.value = progress


func show_tut():
	$tuts.visible = true
	get_tree().paused = true


func _on_exit_tut_button_down() -> void:
	print('runnging')
	$tuts.visible = false
	get_tree().paused = false


func _on_close_tut_button_down() -> void:
	print('running')
	$tuts.visible = false
	get_tree().paused = false

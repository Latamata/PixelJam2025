extends Node

signal UI_signal

var soul_count = 0

func add_souls(soul_amount):
	print(soul_count)
	soul_count += soul_amount
	emit_signal('UI_signal')

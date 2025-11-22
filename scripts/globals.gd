extends Node

var ores := 0

signal ores_changed(value)

func add_ore():
	ores += 1
	emit_signal("ores_changed", ores)

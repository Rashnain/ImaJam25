extends Node

var light_ammo: Array[int] = [100, 100]
var heavy_ammo: Array[int] = [10, 10]

var ores := 0

signal ores_changed(value)

func add_ore():
	ores += 1
	emit_signal("ores_changed", ores)

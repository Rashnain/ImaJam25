extends Node

var light_ammo: Array[int] = [100, 100]
var heavy_ammo: Array[int] = [10, 10]

var ores := 0

signal ores_changed(value)
signal ammo_changed()

func add_ore():
	ores += 1
	emit_signal("ores_changed")

func add_heavy_ammo(player: int, amount: int = 2):
	# On vérifie qu'il y a assez de minerais
	if ores >= amount:
		ores -= amount             # On retire les minerais
		heavy_ammo[player] += amount  # On ajoute la munition
		emit_signal("ammo_changed")
		emit_signal("ores_changed")
	else:
		print("Pas assez de minerais !")

func add_light_ammo(player: int, amount: int = 1):
	if ores >= amount:
		ores -= amount             # On retire les minerais
		light_ammo[player] += amount  # On ajoute la munition
		emit_signal("ammo_changed")
		emit_signal("ores_changed")
	else:
		print("Pas assez de minerais !")

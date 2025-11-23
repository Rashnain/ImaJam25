extends Node

var light_ammo: Array[int] = [100, 100]
var heavy_ammo: Array[int] = [10, 10]

var ores := 0
var alienOres := 10
var upgrades := 0

signal ores_changed()
signal ammo_changed()
signal upgrades_changed()

func add_ore():
	ores += 1 + upgrades
	emit_signal("ores_changed")

func add_heavy_ammo(player: int, amount: int = 2):
	# On vérifie qu'il y a assez de minerais
	if ores >= amount:
		ores -= amount             # On retire les minerais
		heavy_ammo[player] += 1  # On ajoute la munition
		emit_signal("ammo_changed")
		emit_signal("ores_changed")
	else:
		print("Pas assez de minerais !")

func add_light_ammo(player: int, amount: int = 1):
	if ores >= amount:
		ores -= amount             # On retire les minerais
		light_ammo[player] += 1  # On ajoute la munition
		emit_signal("ammo_changed")
		emit_signal("ores_changed")
	else:
		print("Pas assez de minerais !")

func _process(_delta: float) -> void:
	if alienOres >= 10:
		upgrades += 1
		alienOres -= 10
		emit_signal("upgrades_changed")

extends Node

var player_index_bunker: int = 0
var halfday_counter: int = 0

var light_ammo: Array[int] = [100, 100]
var heavy_ammo: Array[int] = [10, 10]
var bunker_text: String
var mine_text: String
var alien_ores: Array[int] = [0, 0]
var ores: Array[int] = [0, 0]
var upgrades : Array[int] = [0, 0]
var on_arcade: bool = true

signal ores_changed()
signal ammo_changed()
signal upgrades_changed()

func _on_half_day_passed() -> void:
	GM.player_index_bunker = (GM.player_index_bunker + 1) % 2

func add_ore():
	ores[1-player_index_bunker] += 1 + upgrades[1-player_index_bunker]
	emit_signal("ores_changed")

func add_heavy_ammo(player: int, amount: int = 2):
	# On vérifie qu'il y a assez de minerais
	if ores[1-player_index_bunker] >= amount:
		ores[1-player_index_bunker] -= amount             # On retire les minerais
		heavy_ammo[player] += 1  # On ajoute la munition
		emit_signal("ammo_changed")
		emit_signal("ores_changed")
	else:
		print("Pas assez de minerais !")

func add_light_ammo(player: int, amount: int = 1):
	if ores[1-player_index_bunker] >= amount:
		ores[1-player_index_bunker] -= amount             # On retire les minerais
		light_ammo[player] += 1  # On ajoute la munition
		emit_signal("ammo_changed")
		emit_signal("ores_changed")
	else:
		print("Pas assez de minerais !")

func _process(_delta: float) -> void:
	if alien_ores[player_index_bunker] >= 10:
		upgrades[player_index_bunker] += 1
		alien_ores[player_index_bunker] -= 10
		emit_signal("upgrades_changed")

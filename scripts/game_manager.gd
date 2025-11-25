extends Node

var player_index_bunker: int = 0
var halfday_counter: int = 0

var light_ammo: Array[int] = [50, 50]
var heavy_ammo: Array[int] = [5, 5]
var life: Array[int] = [10, 10]
var bunker_text: String
var mine_text: String
var alien_ores: Array[int] = [0, 0]
var ores: Array[int] = [0, 0]
var upgrades: Array[int] = [0, 0]
var on_arcade: bool = true

func _on_half_day_passed() -> void:
	GM.player_index_bunker = (GM.player_index_bunker + 1) % 2

func add_ore():
	ores[1-player_index_bunker] += 1 + upgrades[1-player_index_bunker]

func add_heavy_ammo(player: int, amount: int = 2):
	if ores[1-player_index_bunker] >= amount:
		ores[1-player_index_bunker] -= amount
		heavy_ammo[player] += 1

func add_light_ammo(player: int, amount: int = 1):
	if ores[1-player_index_bunker] >= amount:
		ores[1-player_index_bunker] -= amount
		light_ammo[player] += 1

func _process(_delta: float) -> void:
		upgrades[player_index_bunker] += 1
		alien_ores[player_index_bunker] -= 10

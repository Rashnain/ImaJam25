extends Label


var stat_template: String

func _ready() -> void:
	stat_template = text
	update_text()
	GM.connect("ores_changed", _on_ores_changed)
	GM.connect("ammo_changed", _on_ammo_changed)
	GM.connect("upgrades_changed", _on_upgrades_changed)
	
func update_text():
	var player_index := 1-GM.player_index_bunker
	GM.mine_text = stat_template % [GM.ores[player_index], GM.alien_ores[player_index], GM.upgrades[player_index]]


func _on_ores_changed():
	update_text()
	
func _on_ammo_changed():
	update_text()
	
func _on_upgrades_changed():
	update_text()

func _on_half_day_passed() -> void:
	GM.player_index_bunker = (GM.player_index_bunker + 1) % 2
	if position.x < 960:
		position = Vector2i(1031, 1075)
	else:
		position = Vector2i(50, 1075)

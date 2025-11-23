extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_text()
	GM.connect("ores_changed", _on_ores_changed)
	GM.connect("ammo_changed", _on_ammo_changed)
	GM.connect("upgrades_changed", _on_upgrades_changed)
	
func update_text():
	self.text = "Ressources : " + str(GM.ores) \
		+ "\nJ1 - Missiles : " + str(GM.heavy_ammo[0]) + " / Lightballs : " + str(GM.light_ammo[0]) \
		+ "\nJ2 - Missiles : " + str(GM.heavy_ammo[1]) + " / Lightsballs : " + str(GM.light_ammo[1]) \
		+ "\nAméliorations : Minage +" + str(GM.upgrades)


func _on_ores_changed():
	update_text()
	
func _on_ammo_changed():
	update_text()
	
func _on_upgrades_changed():
	update_text()

extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_text()
	GM.connect("ores_changed", _on_ores_changed)
	GM.connect("ammo_changed", _on_ammo_changed)
	
func update_text():
	self.text = "Ressources : " + str(GM.ores) \
		+ "\nMissiles J1 : " + str(GM.heavy_ammo[0]) \
		+ "\nMissiles J2 : " + str(GM.heavy_ammo[1])


func _on_ores_changed():
	update_text()
	
func _on_ammo_changed():
	update_text()

extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = "Ressources : " + str(GM.ores)
	GM.connect("ores_changed", _on_ores_changed)

func _on_ores_changed(value):
	self.text = "Ressources : " + str(value)

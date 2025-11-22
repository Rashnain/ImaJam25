extends Area3D

signal player_entered_zone

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Le joueur est entré dans la zone de minage !")
		emit_signal("player_entered_zone")
		body.is_mining = true
		var mining_ui = preload("res://scenes/MiningUI.tscn").instantiate()
		get_tree().current_scene.add_child(mining_ui)

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.exit_mining()
		body.is_mining = false

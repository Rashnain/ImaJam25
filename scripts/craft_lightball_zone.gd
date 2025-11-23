extends Node

signal player_entered_zone

func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player craft lightball")
		emit_signal("player_entered_zone")
		body.is_crafting_lightball = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Player exit lightball zone")
		body.exit_mining()
		body.is_crafting_lightball = false

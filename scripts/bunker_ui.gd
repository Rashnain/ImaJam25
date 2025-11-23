extends Label


func _process(_delta: float) -> void:
	text = GM.bunker_text


func _on_half_day_passed() -> void:
	GM.player_index_bunker = (GM.player_index_bunker + 1) % 2
	if position.x < 960:
		position = Vector2i(1031, 1075)
	else:
		position = Vector2i(50, 1075)

extends Label


@export var is_bunker_ui: bool


func _ready() -> void:
	if not is_bunker_ui:
		position = Vector2i(100, 100)


func _process(_delta: float) -> void:
	if is_bunker_ui:
		text = GM.bunker_text
	else:
		text = GM.mine_text


func _on_half_day_passed() -> void:
	if position.x < 960:
		position = Vector2i(1031, 1075)
	else:
		position = Vector2i(50, 1075)

	if not is_bunker_ui:
		position.y = 100
		position.x += 50

extends CharacterBody3D

@export var speed := 18.0

var mining_ui = preload("res://scenes/MiningUI.tscn")
var mining_instance = null
var mining_count = 0
var mining_required = 1
var is_mining = false

var is_crafting_missile = false

var is_crafting_lightball = false

var ui_text

func _physics_process(_delta):
	var direction = Vector3.ZERO

	if Input.get_joy_axis(1-GM.player_index_bunker, JOY_AXIS_LEFT_Y) > 0.1 or \
			Input.is_action_pressed("joy_down_p%d" % [1-GM.player_index_bunker]):
		if (GM.player_index_bunker == 0):
			direction.z += 1
		else:
			direction.z -= 1

	if Input.get_joy_axis(1-GM.player_index_bunker, JOY_AXIS_LEFT_Y) < -0.1 or \
			Input.is_action_pressed("joy_up_p%d" % [1-GM.player_index_bunker]):
		if (GM.player_index_bunker == 0):
			direction.z -= 1
		else:
			direction.z += 1

	if Input.get_joy_axis(1-GM.player_index_bunker, JOY_AXIS_LEFT_X) > 0.1 or \
			Input.is_action_pressed("joy_right_p%d" % [1-GM.player_index_bunker]):
		if (GM.player_index_bunker == 0):
			direction.x += 1
		else:
			direction.x -= 1

	if Input.get_joy_axis(1-GM.player_index_bunker, JOY_AXIS_LEFT_X) < -0.1 or \
			Input.is_action_pressed("joy_left_p%d" % [1-GM.player_index_bunker]):
		if (GM.player_index_bunker == 0):
			direction.x -= 1
		else:
			direction.x += 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	
	velocity = direction * speed
	move_and_slide()

	velocity.z = 0
	
func mining_success():
	GM.add_ore()
	
	mining_count = 0

func exit_mining():
	if mining_instance:
		mining_instance.queue_free()

	is_mining = false
	mining_instance = null
	mining_count = 0

func exit_crafting_missile():
	is_crafting_missile = false

func exit_crafting_lightball():
	is_crafting_lightball = false

func _ready():
	var ui = get_parent().get_node("UI/CanvasLayer")
	ui_text = ui.get_node("Label")

func  _input(event: InputEvent) -> void:
	if GM.on_arcade:
		if event is InputEventJoypadButton:
			if event.device == 1-GM.player_index_bunker:
				if is_mining:
					if event.is_action_pressed("button_high_1"):
						mining_count += 1

					if mining_count >= mining_required:
						mining_success()

				if is_crafting_missile:
					if event.is_action_pressed("button_high_1"):
						GM.add_heavy_ammo(GM.player_index_bunker)

				if is_crafting_lightball:
					if event.is_action_pressed("button_high_1"):
						GM.add_light_ammo(GM.player_index_bunker)
	else:
		if is_mining:
			if event.is_action_pressed("button_high_1_p%d" % [1-GM.player_index_bunker]):
				mining_count += 1

			if mining_count >= mining_required:
				mining_success()

		if is_crafting_missile:
			if event.is_action_pressed("button_high_1_p%d" % [1-GM.player_index_bunker]):
				GM.add_heavy_ammo(GM.player_index_bunker)

		if is_crafting_lightball:
			if event.is_action_pressed("button_high_1_p%d" % [1-GM.player_index_bunker]):
				GM.add_light_ammo(GM.player_index_bunker)

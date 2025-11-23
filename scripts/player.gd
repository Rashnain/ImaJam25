extends CharacterBody3D

@export var speed := 15.0

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

	if Input.is_action_pressed("joy_up"):
		direction.z -= 1

	if Input.is_action_pressed("joy_right"):
		direction.x += 1

	if Input.is_action_pressed("joy_left"):
		direction.x -= 1

	if Input.is_action_pressed("joy_down"):
		direction.z += 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	
	velocity = direction * speed
	move_and_slide()

	velocity.z = 0
	
func mining_success():
	GM.add_ore()
	print("Ressource obtenue ! Total =", GM.ores)
	
	mining_count = 0

func exit_mining():
	if mining_instance:
		mining_instance.queue_free()
	
	is_mining = false
	mining_instance = null
	mining_count = 0
	
	print("Minage quitté")
	
func exit_crafting_missile():
	is_crafting_missile = false
	
func exit_crafting_lightball():
	is_crafting_lightball = false

func _ready():
	var ui = get_parent().get_node("UI/CanvasLayer")
	ui_text = ui.get_node("Label")

func  _process(_delta: float) -> void:
	if is_mining:
		if Input.is_action_just_pressed("button_high_1"):
			mining_count += 1
		
		if mining_count >= mining_required:
			mining_success()
			
	if is_crafting_missile:
		if Input.is_action_just_pressed("button_high_1"):
			##if player 1 (index 0)
			GM.add_heavy_ammo(1)
			##if player 2 (index 1)
			## GM.add_heavy_ammo(0)
			
	if is_crafting_lightball:
		if Input.is_action_just_pressed("button_high_1"):
			##if player 1 (index 0)
			GM.add_light_ammo(1)
			##if player 2 (index 1) TODO
			##GM.add_light_ammo(0)
			
	if Input.is_action_just_pressed("button_high_2"):
		if is_mining:
			exit_mining()
		if is_crafting_missile:
			exit_crafting_missile()
		if is_crafting_lightball:
			exit_crafting_lightball()

extends CharacterBody3D

@export var speed := 10.0

var mining_ui = preload("res://scenes/MiningUI.tscn")
var mining_instance = null
var mining_count = 0
var mining_required = 10
var is_mining = false

var is_inside_mining_zone = false


func _physics_process(_delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("joy_up"):
		direction.y += 1

	if Input.is_action_pressed("joy_right"):
		direction.x += 1

	if Input.is_action_pressed("joy_left"):
		direction.x -= 1

	if Input.is_action_pressed("joy_down"):
		direction.y -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	
	velocity = direction * speed
	move_and_slide()

	velocity.z = 0

func start_mining():
	if is_mining:
		return
	is_mining = true
	mining_count = 0
	mining_instance = mining_ui.instance()
	get_node("CanvasLayer").add_child(mining_instance)
	
func mining_success():
	Globals.ores += 1
	print("Ressource obtenue ! Total =", Globals.ores)
	
	mining_count = 0

func exit_mining():
	if mining_instance:
		mining_instance.queue_free()
	
	is_mining = false
	mining_instance = null
	mining_count =0
	
	print("Minage quitté")

func  _process(_delta: float) -> void:
	if is_mining:
		if Input.is_action_just_pressed("button_high_1"):
			mining_count += 1
		print("Mining:", mining_count, "/", mining_required)
		
		if mining_count >= mining_required:
			mining_success()
			
	if Input.is_action_just_pressed("button_high_2"):
		exit_mining()

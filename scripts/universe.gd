extends Node3D


@onready var env: WorldEnvironment = $WorldEnvironment
@onready var hbc: HBoxContainer = $HBoxContainer
@onready var sv1: SubViewport = $HBoxContainer/SubViewportContainer_p1/SubViewport
@onready var sv2: SubViewport = $HBoxContainer/SubViewportContainer_p2/SubViewport
@onready var bunker_ui: Label = $bunker_ui
@onready var mine_ui: Label = $mine_ui
@onready var day_counter: Label = $day_counter
@onready var game_over: Label = $game_over
@onready var game_win: Label = $game_win
@onready var ships: Node3D = $ships

const INVADER = preload("res://scenes/invader.tscn")

@export var invaders_resources: Array[InvaderData]
@export_range(0.5, 10, 0.1) var speed_multiplier: float = 1.0
@export var delayed_spawn: bool = false
@export var spawn_rate: float
var base_spawn_rate: float = 6

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var earth: Node3D = $Earth
@onready var buncker_p_1: Node3D = $HBoxContainer/SubViewportContainer_p1/buncker
@onready var buncker_p_2: Node3D = $HBoxContainer/SubViewportContainer_p2/SubViewport/buncker
@onready var mine_p_1: Node3D = $HBoxContainer/SubViewportContainer_p1/SubViewport/mine
@onready var mine_p_2: Node3D = $HBoxContainer/SubViewportContainer_p2/mine

var dayPosition: int = 1
var gameTime: float = 0.0
var invaders: Array[Node]

func spawnEnnemyAtRandom() -> void:
	for invader_data in invaders_resources:
		if not delayed_spawn or invader_data.spawn_delay <= gameTime:
			var invaderNode = INVADER.instantiate()
			ships.add_child(invaderNode)
			invaderNode.init(invader_data)
			var spawnPosition = Vector3(randf_range(-500, 500), randf_range(-500, 500), dayPosition * 1000)
			invaderNode.global_position = spawnPosition
			var targetPosition = buncker_p_1.global_position if dayPosition == -1 else buncker_p_2.global_position
			invaderNode.setFrontVector(spawnPosition, targetPosition)
			invaders.append(invaderNode)

func updateInvadersPositions(delta) -> void:
	var alive_invaders: Array[Node] = []

	for invader in invaders:
		if is_instance_valid(invader):
			alive_invaders.append(invader)
			invader.global_position += invader.getFrontVector() * invader.base_speed * speed_multiplier * delta

	invaders = alive_invaders

func _on_timeUpdated() -> void:
	dayPosition *= -1
	invaders.clear()
	for ship in ships.get_children():
		ships.remove_child(ship)
		ship.queue_free()
	base_spawn_rate = 6 - GM.halfday_counter/2

func _ready() -> void:
	if FileAccess.open("C:\\Users\\Borne Arcade\\Documents\\je_suis_la_borne_darcade_um.txt", FileAccess.READ) == null:
		GM.on_arcade = false
	else:
		GM.on_arcade = true
	env.half_day_passed.connect(sv1._on_half_day_passed)
	env.half_day_passed.connect(sv2._on_half_day_passed)
	env.half_day_passed.connect(bunker_ui._on_half_day_passed)
	env.half_day_passed.connect(mine_ui._on_half_day_passed)
	env.half_day_passed.connect(GM._on_half_day_passed)
	env.half_day_passed.connect(_on_timeUpdated)

func spawn_rate_curve() -> float:
	var val := int(env.timeOfDay) % 720 / 720.0
	if val < 1.0/3.0:
		return base_spawn_rate + val / (1.0/3.0) * val / (1.0/3.0) * (10 - base_spawn_rate)
	if val > 2.0/3.0:
		return base_spawn_rate + (val-2.0/3.0) / (1.0/3.0) * (val-2.0/3.0) / (1.0/3.0) * (10 - base_spawn_rate)
	return base_spawn_rate

func _process(delta: float) -> void:
	day_counter.text = "Jour %d/5" % [GM.halfday_counter/2.0]
	gameTime += delta
	if spawn_rate <= 0:
		spawn_rate = spawn_rate_curve()
		spawnEnnemyAtRandom()
	if GM.life[GM.player_index_bunker] <= 0 or GM.halfday_counter == 10:
		hbc.visible = false
		earth.visible = false
		bunker_ui.visible = false
		mine_ui.visible = false
		day_counter.visible = false
		buncker_p_1.visible = false
		buncker_p_2.visible = false
		mine_p_1.visible = false
		mine_p_2.visible = false
		if GM.halfday_counter == 10:
			game_win.visible = true
		else:
			game_over.visible = true
		get_tree().paused = true
	spawn_rate -= delta
	updateInvadersPositions(delta)

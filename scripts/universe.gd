extends Node3D


@onready var env: WorldEnvironment = $WorldEnvironment
@onready var sv1: SubViewport = $HBoxContainer/SubViewportContainer_p1/SubViewport
@onready var sv2: SubViewport = $HBoxContainer/SubViewportContainer_p2/SubViewport
@onready var bunker_ui: Label = $bunker_ui

const INVADER = preload("uid://c22145ocwrut1")

@export var invaders_resources: Array[InvaderData]
@export_range(0.5, 10, 0.1) var speed_multiplier: float = 1.0
@export var delayed_spawn: bool = false
@export var spawn_rate: float = 3.0 ##Spawn Rate of Invaders in seconds

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var buncker_p_1: Node3D = $HBoxContainer/SubViewportContainer_p1/buncker
@onready var buncker_p_2: Node3D = $HBoxContainer/SubViewportContainer_p2/SubViewport/buncker

var dayPosition: int = 1
var gameTime: float = 0.0
var invaders: Array[Node]

func spawnEnnemyAtRandom() -> void:
	for invader_data in invaders_resources:
		if not delayed_spawn or invader_data.spawn_delay <= gameTime:
			var invaderNode = INVADER.instantiate()
			invaderNode.init(invader_data)
			var spawnPosition = Vector3(randf_range(-800.0, 800.0),randf_range(-900.0,900.0),dayPosition * 1000.0)
			invaderNode.global_position = spawnPosition
			var targetPosition = buncker_p_1.global_position if dayPosition == -1 else buncker_p_2.global_position
			invaderNode.setFrontVector(spawnPosition, targetPosition)
			add_child(invaderNode)
			invaders.append(invaderNode)

func updateInvadersPositions(delta) -> void:
	for invader in invaders:
		# We assume the front vector is normalised
		invader.global_position += invader.getFrontVector() * invader.base_speed * speed_multiplier * delta

func _on_timeUpdated() -> void:
	dayPosition *= -1

func _ready() -> void:
	env.half_day_passed.connect(sv1._on_half_day_passed)
	env.half_day_passed.connect(sv2._on_half_day_passed)
	env.half_day_passed.connect(bunker_ui._on_half_day_passed)
	env.half_day_passed.connect(_on_timeUpdated)

func _process(delta: float) -> void:
	gameTime += delta
	if spawn_rate <= 0:
		spawn_rate = 3.0
		spawnEnnemyAtRandom()
	spawn_rate -= delta
	updateInvadersPositions(delta)

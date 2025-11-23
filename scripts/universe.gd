extends Node3D


@onready var env: WorldEnvironment = $WorldEnvironment
@onready var sv1: SubViewport = $HBoxContainer/SubViewportContainer_p1/SubViewport
@onready var sv2: SubViewport = $HBoxContainer/SubViewportContainer_p2/SubViewport
@onready var bunker_ui: Label = $bunker_ui


func _ready() -> void:
	env.half_day_passed.connect(sv1._on_half_day_passed)
	env.half_day_passed.connect(sv2._on_half_day_passed)
	env.half_day_passed.connect(bunker_ui._on_half_day_passed)

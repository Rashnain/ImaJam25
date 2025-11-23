extends Node3D


@onready var ui: Label = $bunker/ui_template
@onready var missiles: Node3D = $missiles
@onready var canon: MeshInstance3D = $bunker/canon
var stat_template: String
var light_ammo_cooldown: float = 1
var heavy_ammo_cooldown: float = 5
@export_range(0, 1) var player_index: int


func _ready() -> void:
	stat_template = ui.text


func _process(delta: float) -> void:
	light_ammo_cooldown = clamp(light_ammo_cooldown + delta, 0, 1)
	heavy_ammo_cooldown = clamp(heavy_ammo_cooldown + delta, 0, 5)
	GM.bunker_text = stat_template % [light_ammo_cooldown, GM.light_ammo[player_index],
		heavy_ammo_cooldown, GM.heavy_ammo[player_index], canon.rotation_degrees.x,
		canon.rotation_degrees.z, GM.alien_ores[player_index]]

	var angular_speed = PI / 5 * delta

	# TODO gérer input
	if Input.is_action_pressed("joy_down"):
		canon.rotation.z = clamp(canon.rotation.z - angular_speed, -40.0/360 * 2*PI, 40.0/360 * 2*PI)
	if Input.is_action_pressed("joy_up"):
		canon.rotation.z = clamp(canon.rotation.z + angular_speed, -40.0/360 * 2*PI, 40.0/360 * 2*PI)
	if Input.is_action_pressed("joy_right"):
		canon.rotation.x = clamp(canon.rotation.x + angular_speed, -40.0/360 * 2*PI, 40.0/360 * 2*PI)
	if Input.is_action_pressed("joy_left"):
		canon.rotation.x = clamp(canon.rotation.x - angular_speed, -40.0/360 * 2*PI, 40.0/360 * 2*PI)

	if Input.is_action_just_pressed("button_high_1"):
		if GM.light_ammo[player_index] && light_ammo_cooldown == 1:
			light_ammo_cooldown = 0
			GM.light_ammo[player_index] -= 1
			var missile_scene := preload("res://scenes/light_ball.tscn")
			var missile : Node3D = missile_scene.instantiate()
			#missile.position = Vector3(0, -1, 0)
			missile.rotation = canon.rotation
			missile.speed = 100
			missiles.add_child(missile)

	if Input.is_action_just_pressed("button_high_2"):
		if GM.heavy_ammo[player_index] && heavy_ammo_cooldown == 5:
			heavy_ammo_cooldown = 0
			GM.heavy_ammo[player_index] -= 1
			var missile_scene := preload("res://scenes/missile.tscn")
			var missile : Node3D = missile_scene.instantiate()
			#missile.position = Vector3(0, -1, 0)
			missile.rotation = canon.rotation
			missiles.add_child(missile)

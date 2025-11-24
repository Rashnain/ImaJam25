extends Node3D


@onready var ui: Label = $bunker/ui_template
@onready var missiles: Node3D = $missiles
@onready var canon: MeshInstance3D = $bunker/canon
var stat_template: String
var light_ammo_cooldown: float = 0.5
var heavy_ammo_cooldown: float = 2.5
@export_range(0, 1) var player_index: int
var angular_speed = PI / 5

func _ready() -> void:
	stat_template = ui.text


func _input(event: InputEvent) -> void:
	if GM.on_arcade:
		if event is InputEventJoypadButton and event.device == GM.player_index_bunker:
			if event.is_action_pressed("button_high_1"):
				spawn_light_ammo()
			if event.is_action_pressed("button_high_2"):
				spawn_heavy_ammo()
	else:
		if event.is_action_pressed("button_high_1_p%d" % GM.player_index_bunker):
			spawn_light_ammo()
		elif event.is_action_pressed("button_high_2_p%d" % GM.player_index_bunker):
			spawn_heavy_ammo()


func spawn_light_ammo():
	if GM.light_ammo[player_index] && light_ammo_cooldown == 0.5:
		light_ammo_cooldown = 0
		GM.light_ammo[player_index] -= 1
		var missile_scene := preload("res://scenes/light_ball.tscn")
		var missile : Node3D = missile_scene.instantiate()
		missile.rotation = canon.rotation
		missile.speed = 100
		missiles.add_child(missile)


func spawn_heavy_ammo():
	if GM.heavy_ammo[player_index] && heavy_ammo_cooldown == 2.5:
		heavy_ammo_cooldown = 0
		GM.heavy_ammo[player_index] -= 1
		var missile_scene := preload("res://scenes/missile.tscn")
		var missile : Node3D = missile_scene.instantiate()
		missile.rotation = canon.rotation
		missiles.add_child(missile)


func _process(delta: float) -> void:
	light_ammo_cooldown = clamp(light_ammo_cooldown + delta, 0, 0.5)
	heavy_ammo_cooldown = clamp(heavy_ammo_cooldown + delta, 0, 2.5)

	GM.bunker_text = stat_template % [light_ammo_cooldown, GM.light_ammo[player_index],
		heavy_ammo_cooldown, GM.heavy_ammo[player_index], canon.rotation_degrees.x,
		canon.rotation_degrees.z, GM.alien_ores[player_index], GM.life[player_index]]

	if GM.on_arcade:
		if Input.get_joy_axis(GM.player_index_bunker, JOY_AXIS_LEFT_Y) > 0.1:
			canon.rotation.z = clamp(canon.rotation.z - angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
		if Input.get_joy_axis(GM.player_index_bunker, JOY_AXIS_LEFT_Y) < -0.1:
			canon.rotation.z = clamp(canon.rotation.z + angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
		if Input.get_joy_axis(GM.player_index_bunker, JOY_AXIS_LEFT_X) < -0.1:
			canon.rotation.x = clamp(canon.rotation.x - angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
		if Input.get_joy_axis(GM.player_index_bunker, JOY_AXIS_LEFT_X) > 0.1:
			canon.rotation.x = clamp(canon.rotation.x + angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
	else:
		if GM.player_index_bunker:
			if Input.is_action_pressed("joy_down_p1"):
				canon.rotation.z = clamp(canon.rotation.z - angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
			if Input.is_action_pressed("joy_up_p1"):
				canon.rotation.z = clamp(canon.rotation.z + angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
			if Input.is_action_pressed("joy_left_p1"):
				canon.rotation.x = clamp(canon.rotation.x - angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
			if Input.is_action_pressed("joy_right_p1"):
				canon.rotation.x = clamp(canon.rotation.x + angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
		else:
			if Input.is_action_pressed("joy_down_p0"):
				canon.rotation.z = clamp(canon.rotation.z - angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
			if Input.is_action_pressed("joy_up_p0"):
				canon.rotation.z = clamp(canon.rotation.z + angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
			if Input.is_action_pressed("joy_left_p0"):
				canon.rotation.x = clamp(canon.rotation.x - angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)
			if Input.is_action_pressed("joy_right_p0"):
				canon.rotation.x = clamp(canon.rotation.x + angular_speed * delta, -30.0/360 * 2*PI, 30.0/360 * 2*PI)


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("ship"):
		GM.life[player_index] -= 1

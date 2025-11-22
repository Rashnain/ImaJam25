extends MeshInstance3D

@onready var ui: Label = $ui
@onready var missiles: Node3D = $"../../missiles"
var stat_template: String
var light_ammo: int = 100
var alien_ores: int = 0
var light_ammo_cooldown: float = 1
var heavy_ammo: int = 10
var heavy_ammo_cooldown: float = 5

func _ready() -> void:
	stat_template = ui.text


func _process(delta: float) -> void:
	light_ammo_cooldown = clamp(light_ammo_cooldown + delta, 0, 1)
	heavy_ammo_cooldown = clamp(heavy_ammo_cooldown + delta, 0, 5)
	ui.text = stat_template % [light_ammo_cooldown, light_ammo, heavy_ammo_cooldown, 
								heavy_ammo, rotation_degrees.x, rotation_degrees.z, alien_ores]

	var angular_speed = PI / 5 * delta

	if Input.is_action_pressed("joy_down"):
		rotation.z = clamp(rotation.z - angular_speed, -50.0/360 * 2*PI, 50.0/360 * 2*PI)
	if Input.is_action_pressed("joy_up"):
		rotation.z = clamp(rotation.z + angular_speed, -50.0/360 * 2*PI, 50.0/360 * 2*PI)
	if Input.is_action_pressed("joy_right"):
		rotation.x = clamp(rotation.x + angular_speed, -50.0/360 * 2*PI, 50.0/360 * 2*PI)
	if Input.is_action_pressed("joy_left"):
		rotation.x = clamp(rotation.x - angular_speed, -50.0/360 * 2*PI, 50.0/360 * 2*PI)

	if Input.is_action_just_pressed("button_high_1"):
		if light_ammo && light_ammo_cooldown == 1:
			light_ammo_cooldown = 0
			light_ammo -= 1
			var missile_scene := preload("res://scenes/light_ball.tscn")
			var missile : Node3D = missile_scene.instantiate()
			#missile.position = Vector3(0, -1.5, 0)
			missile.rotation = rotation
			missile.speed = 100
			missiles.add_child(missile)

	if Input.is_action_just_pressed("button_high_2"):
		if heavy_ammo && heavy_ammo_cooldown == 5:
			heavy_ammo_cooldown = 0
			heavy_ammo -= 1
			var missile_scene := preload("res://scenes/missile.tscn")
			var missile : Node3D = missile_scene.instantiate()
			#missile.position = Vector3(0, -1.5, 0)
			missile.rotation = rotation
			missiles.add_child(missile)

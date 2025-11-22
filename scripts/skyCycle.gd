extends WorldEnvironment

@export_category("Sky Control")
@export_range(0, 1440.0, 0.1) var timeOfDay: float = 720.0
@export var simulateTime: bool = false
@export_range(0, 10, 0.1) var rateOfTime: float = 1.0
@export var skyGradient: Gradient

@onready var sun: MeshInstance3D = $"../Sun"

var sunPosition
var sunDistance: float

func simulateDay(delta):
	if simulateTime:
		timeOfDay += rateOfTime * delta
		if timeOfDay >= 1440.0:
			timeOfDay = 0

func updateSunPosition():
	sun.global_position.x = sunDistance * cos(timeOfDay / 720.0 * PI)
	sun.global_position.z = sunDistance * -sin(timeOfDay / 720.0 * PI)

func updateSky():
	var skyMaterial = self.environment.sky.get_material()
	sunPosition = sin(timeOfDay / 720.0 * PI) / 2 + 0.5
	skyMaterial.set_shader_parameter("northSkyColor", skyGradient.sample(sunPosition))
	skyMaterial.set_shader_parameter("southSkyColor", skyGradient.sample(1 - sunPosition))

func _ready() -> void:
	sunDistance = Vector2(sun.global_position.x, sun.global_position.z).length()

func _process(delta: float) -> void:
	simulateDay(delta)
	updateSunPosition()
	updateSky()

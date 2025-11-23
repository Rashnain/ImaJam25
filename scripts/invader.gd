extends Node3D

class_name Invader

@onready var hitbox: Area3D = $Hitbox

var model: Node3D
var frontVector: Vector3
var base_speed: float

func setFrontVector(spawnPosition: Vector3, targetPosition: Vector3) -> void:
	frontVector = (targetPosition - spawnPosition).normalized()
	model.look_at(global_position-frontVector)

func getFrontVector() -> Vector3:
	return frontVector

func _on_area_3d_area_entered(other_area: Area3D):
	if other_area.is_in_group("ammo"):
		GM.alien_ores[GM.player_index_bunker] += 1
		queue_free()


func init(data):
	model = load(data.mesh_path).instantiate()
	model.scale = Vector3(data.mesh_rescale, data.mesh_rescale, data.mesh_rescale)
	add_child(model)
	self.base_speed = data.base_speed

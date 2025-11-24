class_name Missile extends Node3D


@onready var missile: Node3D = $Missile
var speed: float = 20


func _process(delta: float) -> void:
	missile.rotation.y += PI * delta
	missile.position.y += speed * delta

	if missile.position.length_squared() > 100000:
		queue_free()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("ship") and speed == 100:
		queue_free()

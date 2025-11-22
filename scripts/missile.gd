class_name Missile extends Node3D


@onready var missile: Node3D = $Missile
var speed: float = 10


func _process(delta: float) -> void:
	missile.rotation.y += PI * delta
	missile.position.y += speed * delta

	if missile.position.length_squared() > 10000:
		# TODO play explosion
		queue_free()

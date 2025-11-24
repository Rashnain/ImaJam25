class_name Missile extends Node3D


@onready var missile: Node3D = $Missile
var speed: float = 20
@onready var area: Area3D = $Missile/Area3D


func _process(delta: float) -> void:
	missile.rotation.y += PI * delta
	missile.position.y += speed * delta

	if missile.position.length_squared() > 100000:
		# TODO play explosion
		queue_free()

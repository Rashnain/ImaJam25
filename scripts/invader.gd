extends Node3D


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("area entered:", area)
	GM.alien_ores[GM.player_index_bunker] += 1
	queue_free()

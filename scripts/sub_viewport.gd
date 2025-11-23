extends SubViewport


@export var player_index: int

var bunker: Node3D
var mine: Node3D
var current: Node3D
var next: Node3D


func _ready() -> void:
	if player_index == 0:
		bunker = $"../buncker"
		mine = $mine
		current = mine
		next = bunker

	if player_index == 1:
		bunker = $buncker
		mine = $"../mine"
		current = bunker
		next = mine


func _on_half_day_passed() -> void:
	current.visible = false
	current.process_mode = Node.PROCESS_MODE_DISABLED
	remove_child(current)
	get_parent().add_child(current)

	next.visible = true
	next.process_mode = Node.PROCESS_MODE_INHERIT
	get_parent().remove_child(next)
	add_child(next)

	var tmp = current
	current = next
	next = tmp

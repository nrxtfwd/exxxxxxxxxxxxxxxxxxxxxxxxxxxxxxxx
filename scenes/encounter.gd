extends Node2D
class_name Encounter

var enemies = []
var active := false

signal activated

func activate():
	activated.emit()
	active = true
	for enemy in enemies:
		enemy.active = true
		await get_tree().create_timer(0.5).timeout

func _ready() -> void:
	for enemy in get_children():
		enemies.append(enemy)

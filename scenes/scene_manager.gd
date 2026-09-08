extends Node2D
class_name SceneManager

@export var initial_scene : PackedScene

var current_scene

func change_scene(scene : PackedScene):
	if current_scene:
			current_scene.queue_free()
	
	get_tree().paused = false
	current_scene = scene.instantiate()
	add_child(current_scene)

func _ready() -> void:
	Global.scene_manager = self
	change_scene.call_deferred(initial_scene)

extends CharacterBody2D
class_name Entity

var kb := Vector2.ZERO

@export var kb_decay := 3.0

func _physics_process(delta: float) -> void:
	velocity += kb
	kb = kb.move_toward(Vector2.ZERO,kb_decay)

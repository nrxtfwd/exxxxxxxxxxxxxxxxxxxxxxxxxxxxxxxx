extends Area2D

var velocity : Vector2

func _physics_process(delta):
	global_position += velocity * delta
	velocity *= 0.98
	velocity = velocity.move_toward(Vector2.ZERO,4.0)
	if velocity.length() <= 20.0 and velocity.length() > 0.1:
		velocity = Vector2.ZERO
		#await get_tree().process_frame
		for area in get_overlapping_areas():
			_on_area_entered(area)

func _on_area_entered(area):
	if velocity.length() > 1.0:
		return
	Global.money += 1
	queue_free()

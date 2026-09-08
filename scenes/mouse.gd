extends Area2D

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

func _on_timer_timeout():
	if get_overlapping_bodies().size() <= 0:
		$Timer.stop()
		await body_entered
		$Timer.start()
	$AnimationPlayer.stop()
	for body in get_overlapping_bodies():
		Global.damage(self,body,5)
	$AnimationPlayer.play('hit')

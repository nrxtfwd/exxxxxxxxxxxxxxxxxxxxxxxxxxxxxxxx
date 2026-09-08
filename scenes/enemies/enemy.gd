extends Entity
class_name Enemy

@export var speed := 50.0

var active := false

func _physics_process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group('player')
	if !player:
		velocity = Vector2.ZERO
		return
	var player_dir = global_position.direction_to(
		player.global_position
	)
	if active:
		velocity = player_dir * speed
	else:
		velocity = Vector2.ZERO
	super(delta)
	move_and_slide()

func _on_timer_timeout() -> void:
	for body in $hitbox.get_overlapping_bodies():
		Global.damage(self,body,5.0)

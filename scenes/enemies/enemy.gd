extends Entity
class_name Enemy

const MONEY_BILL = preload("uid://cmi34bqjfaf80")

@export var speed := 50.0

var active := false

func on_died():
	for i in range(3):
		var money = MONEY_BILL.instantiate()
		money.global_position = global_position
		money.velocity = Vector2.RIGHT.rotated(
			deg_to_rad(randf_range(-30.0,30.0))
		)*150.0
		Global.scene().add_child(money)

func handle_movement(player):
	var player_dir = global_position.direction_to(
		player.global_position
	)
	var active = $VisibleOnScreenNotifier2D.is_on_screen()
	if active:
		velocity = player_dir * speed
	else:
		velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group('player')
	if !player:
		velocity = Vector2.ZERO
		return
	handle_movement(player)
	super(delta)
	move_and_slide()

func _on_timer_timeout() -> void:
	for body in $hitbox.get_overlapping_bodies():
		Global.damage(self,body,5.0)

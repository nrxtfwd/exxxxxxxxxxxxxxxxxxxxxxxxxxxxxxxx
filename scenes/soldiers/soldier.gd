extends CharacterBody2D

@export var range := 200.0
@export var speed := 50.0

@onready var sprite = $AnimatedSprite2D

func _ready():
	velocity = Vector2.RIGHT * speed

func _physics_process(delta):
	sprite.play('walk' if velocity.x > 0 else 'idle')
	move_and_slide()
	queue_redraw()

func _draw():
	draw_circle(
		Vector2.ZERO,range,Color.WHITE,false,2.0
	)

func attack(enemy):
	$gun.look_at(enemy.global_position)

func get_closest_enemy():
	var closest
	var closest_dist = INF
	for enemy in get_tree().get_nodes_in_group('enemy'):
		var dist = global_position.distance_to(enemy.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest = enemy 

func _on_attack_state_timeout():
	var closest = get_closest_enemy()
	if closest:
		velocity = Vector2.ZERO
		attack(closest)

func _on_attack_timeout():
	attack(get_closest_enemy())

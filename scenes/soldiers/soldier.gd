extends Entity

@export var range := 100.0
@export var speed := 50.0

@onready var sprite = $AnimatedSprite2D

signal died

func _ready():
	walk()

func walk():
	velocity = Vector2.RIGHT * speed

func idle():
	velocity = Vector2.ZERO

func _physics_process(delta):
	sprite.play('walk' if velocity.x > 0 else 'idle')
	super(delta)
	move_and_slide()
	queue_redraw()

func _draw():
	draw_circle(
		Vector2.ZERO,range,Color.WHITE,false,2.0
	)

func attack(enemy):
	enemy.kb += global_position.direction_to(
		enemy.global_position
	) * 50.0
	Global.damage(self,enemy,5.0)
	$gun.look_at(enemy.global_position)

func get_closest_enemy():
	var closest
	var closest_dist = range
	for enemy in get_tree().get_nodes_in_group('enemy'):
		var dist = global_position.distance_to(enemy.global_position)
		if dist < closest_dist:
			closest_dist = dist
			closest = enemy 
	return closest

func _on_attack_state_timeout():
	pass
	#for encounter in get_tree().get_nodes_in_group('encounter'):
		#if encounter.active:
			#break
		#if encounter.global_position.x <= global_position.x:
			#velocity = Vector2.ZERO
			#encounter.activate()
			#break

func _on_attack_timeout():
	var enemy = get_closest_enemy()
	if !enemy:
		walk()
		return
	idle()
	attack(enemy)

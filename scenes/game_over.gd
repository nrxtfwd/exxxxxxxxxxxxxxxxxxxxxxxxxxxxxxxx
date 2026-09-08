extends PanelContainer

const SKILL_TREE = preload("uid://bqxo2n7emfs5y")

func _on_upgrades_pressed():
	Global.change_scene(SKILL_TREE)

func on_soldier_died():
	var is_alive := false
	for soldier in get_tree().get_nodes_in_group('soldier'):
		if soldier.get_node('health_node').health > 0:
			is_alive = true
	if !is_alive:
		visible = true
		get_tree().paused = true

func _ready():
	await get_tree().process_frame
	
	for soldier in get_tree().get_nodes_in_group('soldier'):
		soldier.died.connect(on_soldier_died)

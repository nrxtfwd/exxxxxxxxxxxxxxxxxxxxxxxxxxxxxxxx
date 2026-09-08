extends TextureButton

@export var skill_tree_node : SkillTreeNode

func _ready():
	$Label.text = skill_tree_node.node_name
	pressed.connect(on_pressed)

func on_pressed():
	if skill_tree_node.owned:
		return
	skill_tree_node.owned = true

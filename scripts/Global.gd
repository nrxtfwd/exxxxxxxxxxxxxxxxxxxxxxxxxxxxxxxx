extends Node

const DEATH_HEIGHT = -50.0

var scene_manager : SceneManager
var money := 0 :
	set(value):
		money = value
		money_changed.emit()

signal money_changed

func change_scene(scene = null):
	scene_manager.change_scene(scene)

func damage(from, to, damage):
	to.get_node('health_node').health -= damage

func scene():
	return get_tree().current_scene

func tick():
	return Time.get_ticks_msec()/1000.0

func play(sound_name):
	var sound = AudioStreamPlayer.new()
	sound.process_mode = Node.PROCESS_MODE_ALWAYS
	sound.stream = load('res://sounds/%s.mp3' % sound_name)
	sound.volume_linear = 0.5
	if sound_name == 'swish':
		sound.pitch_scale = 0.85
	get_tree().current_scene.add_child(sound)
	sound.play.call_deferred()
	await sound.finished
	sound.queue_free()

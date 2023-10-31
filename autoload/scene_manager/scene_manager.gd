extends Node2D

enum Scene {
	IntroScreen,
	MainMenu,
	Level,
}

@onready var scenes: Dictionary = {
	Scene.IntroScreen: preload("res://levels/intro_screen/intro_screen.tscn"),
	Scene.MainMenu: preload("res://levels/main_menu/main_menu.tscn"),
	Scene.Level: preload("res://levels/base_level.tscn"),
}

@onready var screen: SubViewport = get_node("/root/main/screen_container/screen")

signal scene_changed(old_scene: String, new_scene: Scene)

var current_scene: NodePath

func change_scene(scene_type: Scene) -> void:
	var fader: BaseUI = UIManager.open_ui(UIManager.UI.Fader)
	var fader_animator: AnimationPlayer = fader.get_node("animator")
	var old_scene = get_tree().current_scene
	await fader_animator.animation_finished
	for child in screen.get_children():
		screen.remove_child(child)
	var instanced_scene = scenes[scene_type].instantiate()
	screen.add_child(instanced_scene)
	current_scene = instanced_scene.get_path()
	UIManager.close_ui(UIManager.UI.Fader)
	await fader_animator.animation_finished
	scene_changed.emit(old_scene, scene_type)

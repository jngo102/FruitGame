extends BaseUI

@onready var animator: AnimationPlayer = $animator
@onready var background_blur: TextureRect = $background_blur
@onready var margin_container: MarginContainer = $margin_container
@onready var menu_buttons: VBoxContainer = margin_container.get_node("menu_buttons")
@onready var quit_warning: VBoxContainer = margin_container.get_node("quit_warning")

func _ready() -> void:
	background_blur.texture = get_window().get_texture()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if is_open:
			UIManager.close_ui(UIManager.UI.PauseMenu)
		else:
			UIManager.open_ui(UIManager.UI.PauseMenu)
			
func open() -> void:
	super.open()
	pause()
	animator.play("Open")
	await animator.animation_finished
	
	
func close() -> void:
	animator.play("Close")
	await animator.animation_finished
	pause(false)
	quit_warning.hide()
	menu_buttons.show()
	super.close()
	
func pause(do_pause: bool = true) -> void:
	get_tree().set_pause(do_pause)

func _on_resume_button_pressed() -> void:
	close()

func _on_quit_button_pressed() -> void:
	menu_buttons.hide()
	quit_warning.show()

func _on_quit_warning_quit_cancel() -> void:
	quit_warning.hide()
	menu_buttons.show()

func _on_quit_warning_quit_confirm() -> void:
	close()
	SceneManager.change_scene(SceneManager.Scene.MainMenu)

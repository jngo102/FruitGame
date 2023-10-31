extends BaseUI

@onready var home_panel: VBoxContainer = $vbox_container
@onready var quit_warning: VBoxContainer = $quit_warning

func _on_main_menu_button_pressed() -> void:
	home_panel.hide()
	quit_warning.show()
	
func _on_restart_button_pressed() -> void:
	UIManager.close_ui(UIManager.UI.GameOverPanel)
	GameManager.start_game()
	
func _on_quit_warning_quit_cancel() -> void:
	quit_warning.hide()
	home_panel.show()

func _on_quit_warning_quit_confirm() -> void:
	UIManager.close_ui(UIManager.UI.GameOverPanel)
	SceneManager.change_scene(SceneManager.Scene.MainMenu)

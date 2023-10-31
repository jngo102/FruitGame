extends BaseUI

@onready var name_entry: LineEdit = $vbox_container/name_entry

func _on_submit_button_pressed() -> void:
	ScoreManager.add_player_to_leaderboard(name_entry.text)
	SaveManager.save_game()
	UIManager.open_ui(UIManager.UI.GameOverPanel)
	UIManager.close_ui(UIManager.UI.EnterLeaderboard)

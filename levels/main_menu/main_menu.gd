extends Control

@onready var leaderboard_entry: PackedScene = preload("res://ui/leaderboard_entry.tscn")

@onready var margin_container: MarginContainer = $margin_container
@onready var menu_buttons = margin_container.get_node("menu_buttons")
@onready var quit_button: Button = menu_buttons.get_node("quit_button")
@onready var leaderboard: VBoxContainer = margin_container.get_node("leaderboard")
@onready var back_button: Button = leaderboard.get_node("back_button")
@onready var quit_warning: VBoxContainer = margin_container.get_node("quit_warning")

func _ready() -> void:
	match OS.get_name():
		"Windows", "macOS", "Linux":
			quit_button.show()
	UIManager.remove_in_game_uis()
	for player in ScoreManager.players:
		var entry: HBoxContainer = leaderboard_entry.instantiate()
		entry.get_node("name").text = "Name: " + player.player_name
		entry.get_node("score").text = "Score: " + str(player.score)
		leaderboard.add_child(entry)
		leaderboard.move_child(back_button, -1)

func _on_back_button_pressed() -> void:
	leaderboard.hide()
	menu_buttons.show()

func _on_leaderboard_button_pressed() -> void:
	menu_buttons.hide()
	leaderboard.show()

func _on_start_button_pressed() -> void:
	GameManager.start_game()

func _on_quit_button_pressed() -> void:
	menu_buttons.hide()
	quit_warning.show()

func _on_quit_warning_quit_cancel() -> void:
	quit_warning.hide()
	menu_buttons.show()

func _on_quit_warning_quit_confirm() -> void:
	get_tree().quit()

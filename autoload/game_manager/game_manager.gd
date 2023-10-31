extends Node

var in_game: bool = false

signal end_game

func start_game() -> void:
	in_game = true
	ScoreManager.reset_score()
	SceneManager.change_scene(SceneManager.Scene.Level)

func game_over() -> void:
	end_game.emit()
	in_game = false

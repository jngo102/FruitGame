extends Node2D
class_name BaseLevel

func _ready() -> void:
	UIManager.call_deferred("add_in_game_uis")

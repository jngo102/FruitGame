extends Node

class ScoreEntry:
	var player_name: String
	var score: int
	
	func _init(n, s) -> void:
		self.player_name = n
		self.score = s

const LEADERBOARD_SLOTS: int = 10

signal new_high_score(new_high_score: int)
signal score_changed(new_score: int)

var current_score: int = 0
var players: Array[ScoreEntry] = []

func _ready() -> void:
	GameManager.end_game.connect(_on_game_over)

func add_player_to_leaderboard(player_name: String) -> void:
	var new_entry := ScoreEntry.new(player_name, current_score)
	if len(players) > 0: 
		for i in range(0, len(players) + 1):
			if i >= len(players) or players[i].score < new_entry.score:
				players.insert(clamp(i, 0, len(players)), new_entry)
				break
	else:
		players.append(new_entry)
	
	if len(players) > LEADERBOARD_SLOTS:
		players.remove_at(len(players) - 1)

func add_to_score(amount: int) -> void:
	current_score += amount
	score_changed.emit(current_score)

func reset_score() -> void:
	current_score = 0
	score_changed.emit(current_score)

func _on_game_over() -> void:
	if (len(players) <= 0 and current_score > 0) or \
		(len(players) > 0 and current_score > players.map(func(player): return player.score).max()):
		print("NEW HIGH SCORE: ", current_score)
		new_high_score.emit(current_score)
		UIManager.open_ui(UIManager.UI.EnterLeaderboard)
	elif (len(players) < LEADERBOARD_SLOTS and current_score > 0) or \
		players.slice(0, LEADERBOARD_SLOTS).any(func(player): return current_score > player.score):
		print("New leaderboard score: ", current_score)
		UIManager.open_ui(UIManager.UI.EnterLeaderboard)
	else:
		UIManager.open_ui(UIManager.UI.GameOverPanel)

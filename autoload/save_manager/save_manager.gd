extends Node

const SAVE_PATH: String = "user://save.json"

func load_game():
	if not FileAccess.file_exists(SAVE_PATH): return
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_str = save_file.get_line()
		var json = JSON.new()
		var parse_res = json.parse(json_str)
		if not parse_res == OK:
			print("JSON parse error: ", json.get_error_message(), " in ", json_str, " at ", json.get_error_line())
			continue
			
		var data = json.get_data()
		var players = data["players"]
		for player in players:
			ScoreManager.players.append(ScoreManager.ScoreEntry.new(player["name"], player["score"]))

func save_game():
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var players = ScoreManager.players.map(func(player): return {
		"name": player.player_name,
		"score": player.score,
	})
	var save_json = {	
		"players": players
	}
	
	save_file.store_line(JSON.stringify(save_json))

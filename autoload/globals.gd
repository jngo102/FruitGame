extends Node

const FRUIT_PATH: String = "actors/fruit/fruits/"

var fruit_order: Array[PackedScene] = []

func _ready() -> void:
	var dir = DirAccess.open(FRUIT_PATH)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				continue
			elif file_name.ends_with(".tscn"):
				var path: String = FRUIT_PATH + file_name
				print("Adding path:\t" + path)
				fruit_order.append(load(path))
			file_name = dir.get_next()

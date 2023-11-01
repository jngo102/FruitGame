extends Node2D
class_name Dropper

@onready var spawn_timer: Timer = $spawn_timer
@onready var left_limit: float = $left_limit.global_position.x
@onready var right_limit: float = $right_limit.global_position.x
var held_fruit: Fruit = null

func _ready() -> void:
	spawn_fruit()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		global_position.x = clampf(event.position.x, left_limit, right_limit)
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		drop(event.position)

func drop(pos: Vector2) -> void:
	if not GameManager.in_game: return
	global_position.x = pos.x
	if held_fruit == null: return
	held_fruit.freeze = false
	remove_child(held_fruit)
	get_node(SceneManager.current_scene).add_child(held_fruit)
	held_fruit.global_position = global_position
	held_fruit.get_node("collision").disabled = false
	held_fruit = null
	spawn_timer.start()
	await spawn_timer.timeout
	spawn_fruit()

func spawn_fruit() -> void:
	var fruit_scene: PackedScene = Globals.spawnable_fruit[randi_range(0, len(Globals.spawnable_fruit) - 1)]
	held_fruit = fruit_scene.instantiate()
	held_fruit.freeze = true
	add_child(held_fruit)

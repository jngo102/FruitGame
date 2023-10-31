extends Area2D
class_name GameOverTrigger

var entered_fruit: Array[Fruit] = []

func _process(_delta: float) -> void:
	for fruit in entered_fruit:
		if fruit.linear_velocity.y <= 0:
			GameManager.game_over()
			queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Fruit:
		entered_fruit.append(body)

func _on_body_exited(body: Node2D) -> void:
	if entered_fruit.has(body):
		entered_fruit.erase(body)

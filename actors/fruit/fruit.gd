extends RigidBody2D
class_name Fruit

const MERGE_TIME: float = 0.25

@onready var collision: CollisionShape2D = $collision

# Whether this fruit will control the merging of both itself and the fruit it is merging with
var merge_controller: bool = false
var new_fruit: Fruit = null

func _on_body_entered(body: Node) -> void:
	if body.scene_file_path != scene_file_path: return
	merge_controller = true
	call_deferred("merge", body)

func merge(other: Fruit) -> void:
	if not merge_controller or other.freeze: return
	other.merge_controller = false
	var index := int(scene_file_path[-6]) + 1
	if index >= len(Globals.fruit_order): return
	freeze = true
	other.freeze = true
	var center: Vector2 = global_position.lerp(other.global_position, 0.5)
	merge_tween(center)
	other.merge_tween(center)
	new_fruit = Globals.fruit_order[index].instantiate()
	get_parent().add_child(new_fruit)
	new_fruit.freeze = true
	new_fruit.global_position = center
	new_fruit.global_scale = Vector2.ZERO
	var grow_tween = create_tween()
	grow_tween.tween_property(new_fruit, "global_scale", Vector2.ONE, MERGE_TIME)
	ScoreManager.add_to_score((index + 1) * 2)

func merge_tween(merge_position: Vector2) -> void:
	var pos_tween = create_tween()
	pos_tween.tween_property(self, "global_position", merge_position, MERGE_TIME).set_trans(Tween.TRANS_CUBIC)
	var shrink_tween = create_tween()
	shrink_tween.tween_property(self, "global_scale", Vector2.ZERO, MERGE_TIME).set_trans(Tween.TRANS_CUBIC)
	pos_tween.finished.connect(func():
		if new_fruit != null:
			new_fruit.freeze = false
		queue_free()
	)

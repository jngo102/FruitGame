extends BaseUI

@onready var value: Label = $margin_container/hbox_container/value

func _ready() -> void:
	ScoreManager.score_changed.connect(_on_score_changed)

func _on_score_changed(new_score: int) -> void:
	value.text = str(new_score)

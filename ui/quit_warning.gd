extends VBoxContainer

signal quit_confirm
signal quit_cancel

func _on_quit_confirm_pressed() -> void:
	quit_confirm.emit()

func _on_quit_cancel_pressed() -> void:
	quit_cancel.emit()

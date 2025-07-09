extends CanvasLayer
@export var runner:Runner

signal restart




func _on_button_pressed() -> void:
	restart.emit()
	runner.end_game()

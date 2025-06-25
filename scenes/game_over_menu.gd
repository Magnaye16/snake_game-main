extends CanvasLayer

signal restart


@onready var game_over_panel = $GameOverPanel
@onready var leaderboard_panel = $LeaderBoardPanel

func _on_restart_button_pressed():
	restart.emit()

func _on_leaderboard_button_pressed():
	game_over_panel.hide()
	leaderboard_panel.show()

func _on_backmenu_button_pressed():
	leaderboard_panel.hide()
	game_over_panel.show()

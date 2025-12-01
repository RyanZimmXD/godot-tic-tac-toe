extends Button



func _on_restart_button_pressed() -> void:
	GameManager.restart_game()
	GameManager.ui_change()


func _on_resume_button_pressed() -> void:
	GameManager.ui_change()


func _on_exit_button_pressed() -> void:
	get_tree().quit()

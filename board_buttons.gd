extends Button

@export var index : int

func _pressed() -> void:
	disabled = true
	text = GameManager.get_player_icon()
	
	GameManager.player_pressed(index)

extends Node

var buttons = []
var game := {}
var players_turn_label
var XTurn := true

var winning_set= [
	[0,1,2],
	[3,4,5],
	[6,7,8],
	
	[0,3,6],
	[1,4,7],
	[2,5,8],
	
	[0,4,8],
	[2,4,6]
]

var ui_opened = false

var button_scene
var player_turn_scene
var basic_ui_scene

func _ready() -> void:
	button_scene = get_tree().current_scene.get_node("button_options")
	player_turn_scene = get_tree().current_scene.get_node("player_turn_label")
	basic_ui_scene = get_tree().current_scene.get_node("basic_ui")
	
	players_turn_label = player_turn_scene.get_child(0)
	buttons.append_array(button_scene.get_children())
	print_debug(buttons.size())

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		ui_change()

func ui_change() -> void:
	if !ui_opened:
		button_scene.visible = false
		player_turn_scene.visible = false
		basic_ui_scene.visible = true
	else:
		button_scene.visible = true
		player_turn_scene.visible = true
		basic_ui_scene.visible = false
	ui_opened = !ui_opened

func restart_game() -> void:
	XTurn = true
	players_turn_label.text = get_player_icon()+"'s Turn"
	for b in buttons:
		b.text = ""
		b.disabled = false
	game.clear()
	
func player_pressed(index: int) -> void:
	game.get_or_add(index, get_player_icon())
	if !_check_win(index):
		XTurn = !XTurn
		players_turn_label.text = get_player_icon()+"'s Turn"

	
	
func get_player_icon() -> String:
	var icon = "X" if XTurn else "O"  
	return icon
	
func _check_win(index: int) -> bool:
	#may God forgive me for I have sinned with this wierd abomination
	for item in winning_set:
		if index in item:
			var count = 0
			for icon in item:
				if game.get(icon) != get_player_icon():
					break
				count += 1
				if count == 3:
					_win()
					return true
	return false


func _win() -> void:
	for button in buttons:
		button.disabled = true
	
	players_turn_label.text = get_player_icon() + "has Won!"

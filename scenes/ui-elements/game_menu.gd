extends Control
class_name GameMenu

var open:bool = false
signal menu_visibility_change(open:bool)

func _ready() -> void:
	set_multiplayer_authority(multiplayer.get_unique_id())

func _on_resume_game_pressed() -> void:
	hide()
	open=false
	menu_visibility_change.emit(open)


func _on_leave_server_pressed() -> void:
	disconnect_from_game(multiplayer.get_unique_id())
	Lobby.remove_multiplayer_peer()
	Lobby.back_to_main_menu()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("menu") && !open:
		show()
		open=true
		menu_visibility_change.emit(open)
	elif Input.is_action_just_pressed("menu") && open:
		hide()
		open=false
		menu_visibility_change.emit(open)

func disconnect_from_game(id:int) -> void:
	var player_manager:PlayerManager = get_node("/root/Main/Players")
	player_manager.client_disconnected.rpc(id)
	

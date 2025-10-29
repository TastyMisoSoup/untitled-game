extends Node

var peer: ENetMultiplayerPeer
var max_players: int
const DEFAULT_IP_ADDRESS = "127.0.0.1"

var player_count: int = 0;

signal on_connected_to_server()

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func create_game(port:int, max_players_param:int):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, max_players_param)
	max_players = max_players_param
	player_count+=1
	if error:
		return error
	multiplayer.multiplayer_peer = peer

func join_game(port:int, address:String = ""):
	if address.is_empty():
		address = DEFAULT_IP_ADDRESS
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, port)
	player_count+=1
	if error:
		return error
	multiplayer.multiplayer_peer = peer

@rpc("call_local", "reliable")
func load_game():
	get_tree().change_scene_to_file("res://main.tscn")

func back_to_main_menu():
	get_tree().change_scene_to_file("res://scenes/ui-elements/title_menu.tscn")

func _on_connected_to_server()-> void:
	load_game()

func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	
func _on_connected_fail():
	remove_multiplayer_peer()
	$FailedToConnect.show()
	
func server_full():
	$ServerFull.show()
	
func _on_server_disconnected():
	remove_multiplayer_peer()
	back_to_main_menu()
	$ServerDisconnected.show()

func is_server_full():
	print(max_players)
	print(player_count)
	return max_players == player_count

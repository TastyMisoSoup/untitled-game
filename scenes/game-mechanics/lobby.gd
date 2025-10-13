extends Node

var peer: ENetMultiplayerPeer
const DEFAULT_IP_ADDRESS = "127.0.0.1"

signal on_connected_to_server()

func _ready() -> void:
	multiplayer.connected_to_server.connect(_on_connected_to_server)

func create_game(port:int, max_players:int):
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, max_players)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

func join_game(port:int, address:String = ""):
	if address.is_empty():
		address = DEFAULT_IP_ADDRESS
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, port)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

@rpc("call_local", "reliable")
func load_game():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_connected_to_server()-> void:
	load_game()

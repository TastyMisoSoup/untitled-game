extends Node2D

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	multiplayer.peer_disconnected.connect(_client_disconnected)
	pass
	
func _client_disconnected(id:int) -> void:
	var player_node = $Players.get_node_or_null(str(id))
	if player_node:
		player_node.queue_free()

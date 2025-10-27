extends Node2D

func _process(delta: float) -> void:
	pass

func get_random_spawn_point() -> Vector2:
	var spawn_point:Marker2D = $Map2/TileMapLayer/SpawnPoints.get_children().pick_random()
	return spawn_point.position

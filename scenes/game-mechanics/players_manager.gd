extends Node

const PLAYER_STATS = preload("res://scenes/ui-elements/score/player_stats.tscn")

@export var stats_manager: Node = null


func _ready() -> void:
	stats_manager = stats_manager if stats_manager else get_node("%StatsManager")

func get_random_spawn_point() -> Vector2:
	var spawn_point:Marker2D = $"../Map2/TileMapLayer/SpawnPoints".get_children().pick_random()
	return spawn_point.position


func add_player_stats(player_name:String,is_owner:bool) -> void:
	var player_stats_inst: Node = PLAYER_STATS.instantiate()
	player_stats_inst.player_name = player_name
	player_stats_inst.rank = stats_manager.get_child_count()
	player_stats_inst.is_owner = is_owner
	stats_manager.add_child(player_stats_inst)

func hide_show_scoreboard() -> void:
	get_node("%Scoreboard").visible = !get_node("%Scoreboard").visible

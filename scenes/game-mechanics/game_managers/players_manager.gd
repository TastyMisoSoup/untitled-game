extends Node

const PLAYER_STATS = preload("res://scenes/ui-elements/score/player_stats.tscn")
const KILL_NOTIFICATION = preload("res://scenes/ui-elements/score/kill_notification.tscn")

@export var stats_manager: Node = null

func _ready() -> void:
	stats_manager = stats_manager if stats_manager else get_node("%StatsManager")

func get_random_spawn_point() -> Vector2:
	var spawn_point:Marker2D = $"../Map2/TileMapLayer/SpawnPoints".get_children().pick_random()
	return spawn_point.position

func add_death(death:int,kill:int,death_name:String,kill_name:String):
	for stats in %StatsManager.get_children():
		if stats.player_id == death: stats.deaths=stats.deaths+1
		stats.update()
	for stats in %StatsManager.get_children():
		if stats.player_id == kill: stats.kills=stats.kills+1
		stats.update()
	var kill_notif = get_kill_notif(death_name,kill_name)
	%KillFeedContainer.add_child(kill_notif)

func add_player_stats(player_name:String,is_owner:bool, player_id) -> void:
	var player_stats_inst: Node = PLAYER_STATS.instantiate()
	player_stats_inst.player_name = player_name
	player_stats_inst.rank = stats_manager.get_child_count()
	player_stats_inst.is_owner = is_owner
	player_stats_inst.player_id = player_id
	stats_manager.add_child(player_stats_inst)

func hide_show_scoreboard() -> void:
	get_node("%Scoreboard").visible = !get_node("%Scoreboard").visible

func get_kill_notif(death_name:String,kill_name:String) -> Node:
	var notif_inst = KILL_NOTIFICATION.instantiate()
	notif_inst.death = death_name
	notif_inst.kill = kill_name
	return notif_inst

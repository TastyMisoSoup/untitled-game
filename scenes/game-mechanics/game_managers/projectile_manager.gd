extends Node

func _ready() -> void:
	$MultiplayerSpawner.set_spawn_function(projectile_spawn)

func projectile_spawn(projectile_data:Dictionary) -> Projectile:
	var projectile_scene = load(projectile_data["projectile_path"])
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.damage = projectile_data["damage"]
	projectile_instance.start_position = projectile_data["start_position"]
	projectile_instance.direction = projectile_data["direction"]
	projectile_instance.team = projectile_data["team"]
	projectile_instance.timer = projectile_data["timer"]
	projectile_instance.player_id = projectile_data["player_id"]
	projectile_instance.player_name = projectile_data["player_name"]
	projectile_instance.speed = projectile_data["speed"]
	return projectile_instance

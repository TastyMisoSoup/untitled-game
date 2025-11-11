extends Node

const PROJECTILE_SCENE = preload("res://scenes/weapons/projectiles/bullet.tscn")

func _ready() -> void:
	$MultiplayerSpawner.set_spawn_function(projectile_spawn)

func projectile_spawn(projectile_data:Dictionary) -> Bullet:
	var projectile_instance = PROJECTILE_SCENE.instantiate()
	projectile_instance.damage = projectile_data["damage"]
	projectile_instance.start_position = projectile_data["start_position"]
	projectile_instance.direction = projectile_data["direction"]
	projectile_instance.team = projectile_data["team"]
	projectile_instance.timer = projectile_data["timer"]
	return projectile_instance

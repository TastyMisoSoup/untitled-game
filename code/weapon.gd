extends Node2D
class_name Weapon

var team: String;
var player_id: int;
var player_name: String;
var start_pos: Vector2;
@export var damage:int;
@export var speed:int;
@export var spread_amount:float

func action():
	pass

func weapon_spread(vector: Vector2) -> Vector2:
	var offset: float = randf_range(-spread_amount,spread_amount)
	return vector + Vector2(offset,offset)

@rpc("any_peer","call_local","unreliable")
func shoot(start_pos,target_pos,timer,projectile_path):
	var direction = Vector2(target_pos - start_pos).normalized()
	direction = weapon_spread(direction)
	if multiplayer.is_server():
		get_node("/root/Main/ProjectileManager/MultiplayerSpawner").spawn({
			"start_position": start_pos,
			"direction": direction,
			"team": team,
			"damage": damage,
			"timer": timer,
			"player_id":player_id,
			"player_name":player_name,
			"speed":speed,
			"projectile_path":projectile_path
		})

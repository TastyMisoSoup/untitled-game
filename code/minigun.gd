extends PrimaryWeapon

const BULLET_PATH: NodePath = "res://scenes/weapons/projectiles/bullet.tscn"

const SPREAD_AMOUNT:float = 0.1;
const DAMAGE: float = 13
const SPEED: int = 450

var weapon_ready: bool = false
var shooting: bool
	
func _process(_delta: float) -> void:
	if shooting && weapon_ready:
		shoot.rpc()

@rpc("any_peer","call_local","reliable")
func action():
	shooting = true
	if $Timer.is_stopped():
		$Timer.start()
		
@rpc("any_peer","call_local","reliable")
func stop_action():
	shooting = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	weapon_ready = true;

@rpc("any_peer","call_local","unreliable")
func shoot():
	weapon_ready = false
	
	var direction = Vector2($Direction.global_position - $Muzzle.global_position).normalized()
	direction = weapon_spread(direction)
	if multiplayer.is_server():
		get_node("/root/Main/ProjectileManager/MultiplayerSpawner").spawn({
			"start_position": $Muzzle.global_position,
			"direction": direction,
			"team": team,
			"damage": DAMAGE,
			"timer": bullet_duration(),
			"player_id":player_id,
			"player_name":player_name,
			"speed":SPEED,
			"projectile_path":BULLET_PATH
		})

func weapon_spread(vector: Vector2) -> Vector2:
	var offset: float = randf_range(-SPREAD_AMOUNT,SPREAD_AMOUNT)
	return vector + Vector2(offset,offset)

func bullet_duration() -> float:
	return randf_range(0.2,0.4)

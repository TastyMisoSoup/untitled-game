extends PrimaryWeapon

const SPREAD_AMOUNT:float = 0.1;
const DAMAGE: float = 13

@export var weapon_ready: bool = false
@export var target_position: Vector2;
var team: String;
var self_hitbox: HurtBox
@export var shooting: bool
var deadzone: bool
	
func _process(_delta: float) -> void:
	if shooting && weapon_ready:
		shoot.rpc(target_position)

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

@rpc("any_peer","call_local","reliable")
func shoot(tar_pos_param):
	weapon_ready = false
	
	var direction = Vector2($Direction.global_position - $Muzzle.global_position).normalized()
	direction = weapon_spread(direction)
	if multiplayer.is_server():
		get_node("/root/Main/ProjectileManager/MultiplayerSpawner").spawn({
			"start_position": $Muzzle.global_position,
			"direction": direction,
			"team": team,
			"damage": DAMAGE,
			"timer": bullet_duration()
		})

func weapon_spread(vector: Vector2) -> Vector2:
	var offset: float = randf_range(-SPREAD_AMOUNT,SPREAD_AMOUNT)
	return vector + Vector2(offset,offset)

func bullet_duration() -> float:
	return randf_range(0.2,0.4)

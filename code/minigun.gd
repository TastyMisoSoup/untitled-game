extends PrimaryWeapon

const SPREAD_AMOUNT:int = 30;
const DAMAGE: float = 6

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
	
	var direction = Vector2(tar_pos_param - $Marker2D.global_position).normalized()
	if multiplayer.is_server():
		get_node("/root/Main/ProjectileManager/MultiplayerSpawner").spawn({
			"start_position": $Marker2D.global_position,
			"direction": direction,
			"team": team,
			"damage": DAMAGE
		})

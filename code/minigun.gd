extends PrimaryWeapon

const BULLET_PATH: NodePath = "res://scenes/weapons/projectiles/bullet.tscn"
var shooting: bool
	
func _process(_delta: float) -> void:
	if shooting && weapon_ready:
		var start_pos = $Muzzle.global_position
		var target_pos = $Direction.global_position
		var duration = bullet_duration()
		shoot.rpc(start_pos,target_pos,duration,BULLET_PATH)
		generate_energy(energy)

@rpc("any_peer","call_local","reliable")
func action(current_energy:int):
	print(current_energy)
	shooting = true
	if $Timer.is_stopped():
		$Timer.start()
		
@rpc("any_peer","call_local","reliable")
func stop_action():
	shooting = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	weapon_ready = true;

func bullet_duration() -> float:
	return randf_range(0.2,0.4)

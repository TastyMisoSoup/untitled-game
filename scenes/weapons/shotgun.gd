extends PrimaryWeapon

const BULLET_PATH: NodePath = "res://scenes/weapons/projectiles/bullet.tscn"
var shooting: bool
var directions: Array

func _ready() -> void:
	weapon_ready = true
	directions = [$Direction,
				$Direction2,
				$Direction3,
				$Direction4,
				$Direction5]

@rpc("any_peer","call_local","reliable")
func action(current_energy:int):
	if weapon_ready:
		weapon_ready = false
		for direction:Marker2D in directions:
			var start_pos = $Muzzle.global_position
			var target_pos = direction.global_position
			var duration = 0.15
			shoot.rpc(start_pos,target_pos,duration,BULLET_PATH)
		generate_energy(energy)
	shooting = true
	if $Timer.is_stopped():
		$Timer.start()
		
@rpc("any_peer","call_local","reliable")
func stop_action():
	pass

func _on_timer_timeout() -> void:
	weapon_ready = true;

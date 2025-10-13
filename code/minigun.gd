extends PrimaryWeapon

const SPREAD_AMOUNT:int = 10;
const DAMAGE: float = 4

var weapon_ready: bool = false
@export var target_position: Vector2;
var team: String;
const projectile = preload("res://scenes/weapons/projectiles/ray_cast_projectile.tscn")
var self_hitbox: HurtBox
var shooting: bool
	
func _process(_delta: float) -> void:
	if shooting:
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

@rpc("any_peer","call_local","reliable")
func shoot():
	var deadzone: bool
	
	if(weapon_ready):		
		weapon_ready = false;
		if(to_local(target_position).x<100): #checks if cursor is in the player deadzone - the minimum weapon range
			target_position = Vector2(50,-58);
			deadzone = true
		else:
			deadzone = false

		var bullet_offset_x = (randi_range(-SPREAD_AMOUNT,SPREAD_AMOUNT)) #bullet spread
		var bullet_offset_y = (randi_range(-SPREAD_AMOUNT,SPREAD_AMOUNT))
		target_position.y = target_position.y + bullet_offset_y
		target_position.x = target_position.x + bullet_offset_x
		var projectile_instance = RayCastProjectile.projectile_construct(deadzone, $Marker2D.position, target_position, team, self_hitbox)
		$MultiplayerSpawner.get_node($MultiplayerSpawner.spawn_path).add_child(projectile_instance, true)

extends PrimaryWeapon

const SPREAD_AMOUNT:int = 5;
const DAMAGE: float = 4

var weapon_ready: bool = false
var target_position: Vector2;
var team: String;
var projectile = preload("res://scenes/weapons/projectiles/ray_cast_projectile.tscn")
	
func _process(delta: float) -> void:
	var deadzone: bool
	
	if(weapon_ready):		
		weapon_ready = false;
		if(get_local_mouse_position().x<100): #checks if cursor is in the player deadzone - the minimum weapon range
			target_position = Vector2(50,-58);
			deadzone = true
		else:
			deadzone = false

		var bullet_offset_x = (randi_range(-SPREAD_AMOUNT,SPREAD_AMOUNT)) #bullet spread
		var bullet_offset_y = (randi_range(-SPREAD_AMOUNT,SPREAD_AMOUNT))
		target_position.y = target_position.y + bullet_offset_y
		target_position.x = target_position.x + bullet_offset_x
		var projectile_instance = RayCastProjectile.projectile_construct(deadzone, $Marker2D.position, target_position, team)
		add_child(projectile_instance)


func action():
	if $Timer.is_stopped():
		$Timer.start()
		
func stop_action():
	$Timer.stop()

func _on_timer_timeout() -> void:
	weapon_ready = true;

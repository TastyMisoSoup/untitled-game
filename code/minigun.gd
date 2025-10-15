extends PrimaryWeapon

const SPREAD_AMOUNT:int = 10;
const DAMAGE: float = 4

@export var weapon_ready: bool = false
@export var target_position: Vector2;
var team: String;
const PROJECTILE_SCENE = preload("res://scenes/weapons/projectiles/ray_cast_projectile.tscn")
var self_hitbox: HurtBox
@export var shooting: bool
var deadzone: bool
	
func _ready() -> void:
	print("weapon"+team)
	#$MultiplayerSpawner.set_spawn_path(ProjectileManager.get_path())
	$MultiplayerSpawner.set_spawn_function(projectile_spawn)
	
func _process(_delta: float) -> void:
	if shooting && weapon_ready:
		shoot.rpc()

#@rpc("authority","call_local","reliable")
func action():
	shooting = true
	if $Timer.is_stopped():
		$Timer.start()
		
#@rpc("authority","call_local","reliable")
func stop_action():
	shooting = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	weapon_ready = true;

@rpc("any_peer","call_local","reliable")
func shoot():
	if !multiplayer.is_server(): return
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
	$MultiplayerSpawner.spawn([deadzone,$Marker2D.position,target_position,team,self_hitbox])

func projectile_spawn(projectile_data):
	var projectile_instance = PROJECTILE_SCENE.instantiate()
	projectile_instance.deadzone = projectile_data[0]
	projectile_instance.start_position = projectile_data[1]
	projectile_instance.target_position = projectile_data[2]
	projectile_instance.team = projectile_data[3]
	#projectile_instance.self_hitbox = projectile_data[4]
	return projectile_instance

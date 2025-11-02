extends PrimaryWeapon

const SPREAD_AMOUNT:int = 30;
const DAMAGE: float = 4

@export var weapon_ready: bool = false
@export var target_position: Vector2;
var team: String;
const PROJECTILE_SCENE = preload("res://scenes/weapons/projectiles/ray_cast_projectile.tscn")
var self_hitbox: HurtBox
@export var shooting: bool
var deadzone: bool
	
func _ready() -> void:
	set_multiplayer_authority(1)
	$MultiplayerSpawner.set_multiplayer_authority(1)
	$MultiplayerSpawner.set_spawn_function(projectile_spawn)
	
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
func shoot(target_position_param):
	weapon_ready = false;
	$RayCast2D.target_position = $RayCast2D.to_local(target_position_param)
	if(to_local(target_position_param).x<100): #checks if cursor is in the player deadzone - the minimum weapon range
		$RayCast2D.target_position = Vector2(50,-58);
		deadzone = true
	else:
		$RayCast2D.target_position = $RayCast2D.to_local(target_position_param)
		deadzone = false
	$RayCast2D.target_position = weapon_spread($RayCast2D.target_position)
	if $RayCast2D.is_colliding():	#checks if raycast hits, if so, deals damage
		var collision_point: Vector2 = $RayCast2D.get_collision_point()
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("hurt_box") && !collider.is_in_group(team):
			collider.raycast_hit.rpc_id(collider.multiplayer.get_unique_id(),-5)
		$RayCast2D.target_position = $RayCast2D.to_local(collision_point)
	#target_position_param = weapon_spread(target_position_param);
	#if multiplayer.is_server():
		#$MultiplayerSpawner.spawn({"deadzone":deadzone,"start_position":$Marker2D.position,"target_position":target_position_param,"team":team})

func projectile_spawn(projectile_data:Dictionary) -> RayCastProjectile:
	var projectile_instance = PROJECTILE_SCENE.instantiate()
	projectile_instance.deadzone = projectile_data["deadzone"]
	projectile_instance.start_position = projectile_data["start_position"]
	projectile_instance.target_position = projectile_data["target_position"]
	projectile_instance.team = projectile_data["team"]
	return projectile_instance

func weapon_spread(target_position_param:Vector2) -> Vector2:
	var bullet_offset_x = (randi_range(-SPREAD_AMOUNT,SPREAD_AMOUNT)) #bullet spread
	var bullet_offset_y = (randi_range(-SPREAD_AMOUNT,SPREAD_AMOUNT))
	target_position_param.y = target_position_param.y + bullet_offset_y
	target_position_param.x = target_position_param.x + bullet_offset_x
	return target_position_param

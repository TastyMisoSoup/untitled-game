extends Weapon

@export var stats: PrimaryWeaponStats
var damage: float

func _ready() -> void:
	$Timer.wait_time = stats.weapon_speed
	damage = stats.weapon_damage


func action():
	$Timer.start()

func stop_action():
	$Timer.stop()

func _on_timer_timeout() -> void:
	var target_position: Vector2;
	var deadzone: bool
	var spread_amount:int = 5
	$AnimationPlayer.play("shoot")
	if(position.distance_to(get_local_mouse_position())<150): #checks if cursor is in the player deadzone - the minimum weapon range
		target_position = Vector2(50,get_local_mouse_position().y);
		deadzone = true
	else:
		target_position = get_global_mouse_position()
		deadzone = false
	var bullet_offset_x = (randi_range(-spread_amount,spread_amount)) #bullet spread
	var bullet_offset_y = (randi_range(-spread_amount,spread_amount))
	target_position.y = target_position.y + bullet_offset_y
	target_position.x = target_position.x + bullet_offset_x
	if(deadzone):
		$RayCast2D.set_target_position(target_position)	
		$Line2D.set_point_position(1,Vector2(30+bullet_offset_x,target_position.y))	
		#deadzone line2d and raycast2d pos needs to be reworked, the spread isnt wide enough
	else:
		$RayCast2D.set_target_position($RayCast2D.to_local(target_position))
		$Line2D.set_point_position(1,$Line2D.to_local(target_position))
		
	if $RayCast2D.is_colliding():	#checks if raycast hits, if so, deals damage
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("hurt_box") && collider.is_in_group("enemy"):
			collider.raycast_hit(damage)
		var collision_point: Vector2 = $RayCast2D.get_collision_point()
		$Line2D.set_point_position(1,($Line2D.to_local(collision_point)))

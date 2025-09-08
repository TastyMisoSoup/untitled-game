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
	$AnimationPlayer.play("shoot")
	if(get_local_mouse_position().y>-40):
		target_position = Vector2(get_local_mouse_position().x,-40);
	else:
		target_position = get_global_mouse_position();
	var bullet_offset_x = (randi_range(-5,5))
	var bullet_offset_y = (randi_range(-5,5))
	target_position.y = target_position.y + bullet_offset_y
	target_position.x = target_position.x + bullet_offset_x
	$RayCast2D.set_target_position($RayCast2D.to_local(target_position))
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("hurt_box") && collider.is_in_group("enemy"):
			collider.raycast_hit(damage)
		var collision_point: Vector2 = $RayCast2D.get_collision_point()
		$Line2D.set_point_position(1,($Line2D.to_local(collision_point)))
	else:
		$Line2D.set_point_position(1,$Line2D.to_local(target_position))

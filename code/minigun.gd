extends Weapon

@export var stats: WeaponStats
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
		target_position = get_local_mouse_position();
	#position.y = position.y + (randi_range(0,0))
	$RayCast2D.set_target_position(target_position)
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("hurt_box") && collider.is_in_group("enemy"):
			collider.raycast_hit(damage)
		var collision_point: Vector2 = $RayCast2D.get_collision_point()
		$Line2D.set_point_position(1,($Line2D.to_local(collision_point)))
	else:
		$Line2D.set_point_position(1,$Line2D.to_local(get_global_mouse_position()))

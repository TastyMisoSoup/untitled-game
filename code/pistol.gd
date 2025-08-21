extends Weapon

func action():
	$Timer.start()

func stop_action():
	$Timer.stop()

func _on_timer_timeout() -> void:
	var position: Vector2;
	$AnimationPlayer.play("shoot")
	if(get_local_mouse_position().y>-100):
		position = Vector2(get_local_mouse_position().x,-100);
	#elif(get_local_mouse_position().y<-200):
		#position = Vector2(get_local_mouse_position().x,-200);
	else:
		position = get_local_mouse_position();
	position.x = position.x + (randi_range(-40,40))
	position.y = position.y + (randi_range(-10,10))
	$RayCast2D.set_target_position(position)
	if $RayCast2D.is_colliding():
		var collision_point: Vector2 = $RayCast2D.get_collision_point()
		print(collision_point-$Line2D.global_position)
		$Line2D.set_point_position(1,($Line2D.to_local(collision_point)))
	else:
		$Line2D.set_point_position(1,position)

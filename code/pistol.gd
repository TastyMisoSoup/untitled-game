extends "./weapon.gd"

func action():
	var position: Vector2;
	$AnimationPlayer.play("shoot")
	if(get_local_mouse_position().y>-60):
		position = Vector2(get_local_mouse_position().x,-60);
	elif(get_local_mouse_position().y<-200):
		position = Vector2(get_local_mouse_position().x,-200);
	else:
		position = get_local_mouse_position();
	$Line2D.set_point_position(1,position)
	$RayCast2D.set_target_position(position)
	$RayCast2D.set_enabled(true)
	print($RayCast2D.is_colliding())
	$RayCast2D.set_enabled(false)

extends Projectile
class_name Grenade

func _ready() -> void:
	position = start_position
	look_at(global_position + direction)
	add_to_group(team)
	velocity = direction * speed
	$Timer.start(timer)
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	var collision:KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var reflect = collision.get_remainder().bounce(collision.get_normal())
		velocity = (velocity / 1.8).bounce(collision.get_normal())
		move_and_collide(reflect)



func _on_timer_timeout() -> void:
	explode()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") && !area.is_in_group(team) && multiplayer.is_server():
		explode()

func explode() -> void:
	velocity = Vector2.ZERO
	$AnimatedSprite2D.visible = false
	$CPUParticles2D.emitting = false
	$Explosion.play("explosion")
	for player in $ExplosionRadius.get_overlapping_areas():
		$RayCast2D.target_position = to_local(player.global_position)
		$RayCast2D.force_raycast_update()
		if !$RayCast2D.is_colliding():
			player.hit.rpc_id(1,{"amount":-damage,"source_id":player_id,"source_name":player_name})


func _on_explosion_animation_finished() -> void:
	queue_free()

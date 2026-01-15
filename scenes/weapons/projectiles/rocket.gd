extends Projectile
class_name Rocket

func _ready() -> void:
	position = start_position
	look_at(to_global(direction))
	add_to_group(team)
	velocity = direction * speed
	$Timer.start(timer)
	$AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	move_and_slide()



func _on_timer_timeout() -> void:
	explode()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") && !area.is_in_group(team):
		explode()

func explode() -> void:
	velocity = Vector2.ZERO
	$AnimatedSprite2D.visible = false
	$CPUParticles2D.emitting = false
	$Explosion.play("explosion")
	for player:Area2D in $ExplosionRadius.get_overlapping_areas():
		if player.is_in_group(team): return
		$RayCast2D.target_position = to_local(player.global_position)
		$RayCast2D.force_raycast_update()
		if !$RayCast2D.is_colliding() and multiplayer.is_server():
			player.hit.rpc_id(1,{"amount":-damage,"source_id":player_id,"source_name":player_name})


func _on_explosion_animation_finished() -> void:
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	explode()


func _on_hitbox_body_entered(body: Node2D) -> void:
	explode()

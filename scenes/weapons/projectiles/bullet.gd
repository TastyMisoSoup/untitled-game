extends Projectile
class_name Bullet

func _ready() -> void:
	position = start_position
	look_at(global_position + direction)
	add_to_group(team)
	velocity = direction * speed
	$Timer.start(timer)

func _physics_process(_delta: float) -> void:
	if stopped: return
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") && !area.is_in_group(team) && multiplayer.is_server():
		area.hit.rpc_id(1,{"amount":-damage,"source_id":player_id,"source_name":player_name})
	disappear()

func disappear() ->void:
	stopped = true
	$AnimatedSprite2D.play("explosion")

func _on_area_2d_body_entered(body: Node2D) -> void:
	disappear()

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	disappear()

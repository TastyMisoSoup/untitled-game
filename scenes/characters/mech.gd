extends CharacterBody2D

const SPEED: int = 200

func move(input_direction) -> void:
	velocity = input_direction * SPEED
	$DefaultLegs.move_legs(input_direction)
	move_and_slide()

func primary_weapon_action(target_position: Vector2) -> void:
	$Body.primary_weapon_action(target_position)

func primary_weapon_action_stop() -> void:
	$Body.primary_weapon_action_stop()

func mech_look_at(target_position: Vector2) -> void:
	$Body.look_at(target_position)



func _on_hitbox_on_raycast_hit(amount) -> void:
	$Mech/Health.change_health(amount)
	if $Mech/Health.health <= 0:
		queue_free()
	print($Mech/Health.health)

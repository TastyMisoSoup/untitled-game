extends CharacterBody2D
class_name Mech

const SPEED: int = 200
var speed_modifier: float;
const MECH_SCENE = preload("res://scenes/characters/mech.tscn")
var team: String;
var dashing: bool = false

static func mech_construct(team: String,speed_modifier):
	var mech_instance = MECH_SCENE.instantiate()
	mech_instance.speed_modifier = speed_modifier
	mech_instance.team = team
	return mech_instance

func _ready() -> void:
	$Body/Minigun.team = team;
	$Hitbox.add_to_group(team)

func move(input_direction) -> void:
	velocity = input_direction * SPEED * speed_modifier
	if dashing:
		velocity = velocity * 3
	$DefaultLegs.move_legs(input_direction)
	move_and_slide()
	
func dash() -> void:
	dashing = true
	set_collision_mask_value(1,false)
	$Dash_Duration.start()



func primary_weapon_action(target_position: Vector2) -> void:
	$Body.primary_weapon_action(target_position)

func primary_weapon_action_stop() -> void:
	$Body.primary_weapon_action_stop()

func mech_look_at(target_position: Vector2) -> void:
	$Body.look_at(target_position)

func _on_hitbox_on_raycast_hit(amount) -> void:
	$Health.change_health(amount)
	if $Health.health <= 0:
		queue_free()
	print($Health.health)


func _on_dash_duration_timeout() -> void:
	set_collision_mask_value(1,true)
	dashing = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fall":
		queue_free()

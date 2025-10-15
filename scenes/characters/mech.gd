extends CharacterBody2D
class_name Mech

signal team_change(team_name:String);

const SPEED: int = 200
const MECH_SCENE = preload("res://scenes/characters/mech.tscn")

var speed_modifier: float;
var label_name: String;

@export var team: String;
var dashing: bool = false

func _ready() -> void:
	print("bababooey"+str(get_multiplayer_authority()))
	$Body.set_primary_weapon(MechConfig.primary_weapon, $Hitbox, team)
	$Body.set_secondary_weapon(MechConfig.secondary_weapon, $Hitbox)
	var mech_stats = set_mech_body(MechConfig.mech_body)
	$HealthPlayer.max_health = mech_stats.HEALTH
	$HealthPlayer.health = $HealthPlayer.max_health
	$HealthPlayer.update()
	speed_modifier = mech_stats.SPEED_MODIFIER
	$Body/Sprite2D.texture = mech_stats.TEXTURE
	#$Body.team = team;
	$Hitbox.add_to_group(team)
	$Label.text = team
	if is_multiplayer_authority():
		$Camera2D.make_current()

func move(input_direction) -> void:
	if !is_multiplayer_authority(): return
	velocity = input_direction * SPEED * speed_modifier
	if dashing:
		velocity = velocity * 2.4
	$DefaultLegs.move_legs(input_direction)
	move_and_slide()
	
func dash() -> void:
	dashing = true
	set_collision_mask_value(1,false)
	$DashDuration.start()

func primary_weapon_action(target_position: Vector2) -> void:
	if !is_multiplayer_authority(): return
	$Body.primary_weapon.target_position = target_position
	$Body.primary_weapon.action()

func primary_weapon_action_stop() -> void:
	if !is_multiplayer_authority(): return
	$Body.primary_weapon.stop_action()

func mech_look_at(target_position: Vector2) -> void:
	if !is_multiplayer_authority(): return
	$Body.look_at(target_position)

func _on_hitbox_on_raycast_hit(amount) -> void:
	$HealthPlayer.change_health(amount)
	print($Hitbox.get_groups())
	if $HealthPlayer.health <= 0:
		queue_free()


func _on_dash_duration_timeout() -> void:
	set_collision_mask_value(1,true)
	dashing = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fall":
		queue_free()

func set_mech_body(mech_body_str) -> Resource:
	if ValidScenePaths.MECH_BODIES.has(mech_body_str):
		return load("res://resources/stats/mechs/"+mech_body_str+".tres")
	else: 
		return load("res://resources/stats/mechs/daemon.tres")


func _on_dash_cooldown_timeout() -> void:
	pass # Replace with function body.

func change_team(team_name:String):
	team_change.emit(team_name)

func _on_team_change(team_name: String) -> void:
	$Body.primary_weapon.team = team_name;
	$Hitbox.add_to_group(team_name)


func _on_ready() -> void:
	change_team(team)

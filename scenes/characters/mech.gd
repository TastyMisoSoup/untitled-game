extends CharacterBody2D
class_name Mech

signal team_change(team_name:String);

@export var body: Node = null
@export var hitbox: Node = null
@export var health: Node = null
@export var legs: Node = null
@export var animation_player: Node = null

const SPEED: int = 200

var speed_modifier: float;
var label_name: String;
@export var alive: bool = true

@export var team: String;
var dashing: bool = false
var dash_on_cd: bool = false
var falling = false
var controllable = true



func _ready() -> void:
	body = body if body else $Body
	hitbox = hitbox if hitbox else $Hitbox
	health = health if health else $HealthPlayer
	legs = legs if legs else $DefaultLegs
	animation_player = animation_player if animation_player else $AnimationPlayer

	body.set_primary_weapon(MechConfig.primary_weapon, hitbox, team)
	body.set_secondary_weapon(MechConfig.secondary_weapon, hitbox)
	var mech_stats = set_mech_body(MechConfig.mech_body)
	health.max_health = mech_stats.HEALTH
	health.health = health.max_health
	health.update()
	speed_modifier = mech_stats.SPEED_MODIFIER
	body.set_texture(mech_stats.TEXTURE)
	#body.team = team;
	hitbox.add_to_group(team)
	
	$Label.text = "Player"+str(multiplayer.get_unique_id())
	if is_multiplayer_authority():
		$Camera2D.make_current()
		health.HUD_visible()

func move(input_direction) -> void:
	if !is_multiplayer_authority() or !alive: return
	velocity = compute_velocity(input_direction, speed_modifier, dashing)
	legs.move_legs(input_direction)
	move_and_slide()

func compute_velocity(input_direction:Vector2, speed_modifier_param:float,dashing_param:bool) -> Vector2:
	velocity = input_direction * SPEED * speed_modifier_param
	if dashing_param:
		velocity = velocity * 2.4
	return velocity
	
@rpc("any_peer","call_local")
func dash() -> void:
	if dash_on_cd: return
	dash_on_cd = true
	dashing = true
	set_collision_mask_value(1,false)
	hitbox.set_collision_layer_value(6,false)
	#hitbox.monitorable = false
	$DashDuration.start()
	$DashCooldown.start()


func primary_weapon_action(target_position: Vector2) -> void:
	if !is_multiplayer_authority()||!alive: return
	#print(target_position)
	body.primary_weapon.target_position = target_position
	#print(body.primary_weapon.target_position)
	body.primary_weapon.action.rpc_id(multiplayer.get_unique_id())

func primary_weapon_action_stop() -> void:
	if !is_multiplayer_authority()||!alive: return
	body.primary_weapon.stop_action.rpc_id(multiplayer.get_unique_id())

func mech_look_at(target_position: Vector2) -> void:
	if !is_multiplayer_authority()||!alive: return
	body.look_at(target_position)

func _on_hitbox_on_hit(amount) -> void:
	health.change_health.rpc(amount)
	if health.health <= 0:
		die.rpc()


func _on_dash_duration_timeout() -> void:
	set_collision_mask_value(1,true)
	hitbox.set_collision_layer_value(6,true)
	set_collision_layer_value(5,true)
	dashing = false
	if falling:
		fall.rpc()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fall":
		die()

func set_mech_body(mech_body_str) -> Resource:
	if ValidScenePaths.MECH_BODIES.has(mech_body_str):
		return load("res://resources/stats/mechs/"+mech_body_str+".tres")
	else: 
		return load("res://resources/stats/mechs/daemon.tres")


func _on_dash_cooldown_timeout() -> void:
	dash_on_cd = false

func change_team(team_name:String):
	team_change.emit(team_name)

func _on_team_change(team_name: String) -> void:
	body.primary_weapon.team = team_name;
	hitbox.add_to_group(team_name)

@rpc("any_peer","call_local")
func die() -> void:
	alive = false
	body.primary_weapon.shooting = false
	hitbox.set_collision_layer_value(5,false)
	set_collision_layer_value(5,false)
	$DeathTimer.start()
	if is_multiplayer_authority():
		$CanvasLayer.show()
	hide()
	
@rpc("any_peer","call_local")
func respawn() -> void:
	scale = Vector2(1,1)
	modulate = Color(1,1,1,1)
	alive = true
	health.change_health(999)
	position = $"../../../Players".get_random_spawn_point()
	hitbox.set_collision_layer_value(5,true)
	set_collision_layer_value(5,true)
	if is_multiplayer_authority():
		$CanvasLayer.hide()
	show()

func _on_ready() -> void:
	change_team(team)

func _on_death_timer_timeout() -> void:
	respawn.rpc()

func _on_fall_check_area_entered(area: Area2D) -> void:
	if area.is_in_group("death_pit"):
		falling = true


func _on_fall_check_area_exited(area: Area2D) -> void:
	if area.is_in_group("death_pit") && !$FallCheck.has_overlapping_areas():
		falling = false

@rpc("any_peer","call_local","reliable")
func fall() -> void:
	alive = false
	body.primary_weapon.shooting = false
	animation_player.play("fall")

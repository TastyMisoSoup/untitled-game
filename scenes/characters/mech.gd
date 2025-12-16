extends CharacterBody2D
class_name Mech

signal team_change(team_name:String);

@export var body: Body = null
@export var hitbox: HurtBox = null
@export var resource_tracker: ResourceTracker = null
@export var legs: Legs = null
@export var animation_player: AnimationPlayer = null

var mech_body

const SPEED: int = 200
var main_path: Node

var speed_modifier: float;
@export var alive: bool = true

@export var team: String;
var player_id: int;
var player_name: String;

var dashing: bool = false
var dash_on_cd: bool = false
var falling = false
var controllable = true
var overloaded = false



func _ready() -> void:
	body = body if body else $Body
	hitbox = hitbox if hitbox else $Hitbox
	resource_tracker = resource_tracker if resource_tracker else $ResourceTrackerPlayer
	legs = legs if legs else $DefaultLegs
	animation_player = animation_player if animation_player else $AnimationPlayer
	main_path = get_node("./../../../Players")

	body.set_primary_weapon(PlayerConfig.primary_weapon, team, player_id, player_name)
	body.set_secondary_weapon(PlayerConfig.secondary_weapon, team, player_id, player_name)
	body.primary_weapon.weapon_action.connect(change_energy)
	body.secondary_weapon.weapon_action.connect(change_energy)
	
	var mech_stats = set_mech_body(mech_body)
	speed_modifier = mech_stats.SPEED_MODIFIER
	body.set_texture(mech_stats.TEXTURE)
	hitbox.add_to_group(team)
	
	set_health(mech_stats.HEALTH)
	set_energy(mech_stats.ENERGY)
	
	$Label.text = player_name
	if is_multiplayer_authority():
		$Camera2D.make_current()
		resource_tracker.HUD_visible()


#Setters
func set_mech_body(mech_body_str) -> Resource:
	if ValidScenePaths.MECH_BODIES.has(mech_body_str):
		return load("res://resources/stats/mechs/"+mech_body_str+".tres")
	else: 
		return load("res://resources/stats/mechs/daemon.tres")


func set_health(health_param:float) -> void:
	resource_tracker.max_health = health_param
	resource_tracker.health = resource_tracker.max_health
	resource_tracker.update_health()


func set_energy(energy_param:int) -> void:
	resource_tracker.max_energy = energy_param
	resource_tracker.energy = 0
	resource_tracker.update_energy()


func change_team(team_name:String):
	team_change.emit(team_name)


func _on_team_change(team_name: String) -> void:
	body.primary_weapon.team = team_name;
	hitbox.add_to_group(team_name)


#Movement
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
	$DashDuration.start()
	$DashCooldown.start()
	$CPUParticles2D.emitting = true


func _on_dash_duration_timeout() -> void:
	set_collision_mask_value(1,true)
	hitbox.set_collision_layer_value(6,true)
	set_collision_layer_value(5,true)
	$CPUParticles2D.emitting = false
	dashing = false
	if falling:
		fall.rpc()


func _on_dash_cooldown_timeout() -> void:
	dash_on_cd = false


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


#Actions
func primary_weapon_action() -> void:
	if overloaded: return
	if resource_tracker.energy == resource_tracker.max_energy: 
		body.primary_weapon.stop_action.rpc_id(multiplayer.get_unique_id())
		overload.rpc()
		return
	if !is_multiplayer_authority()||!alive: return
	body.primary_weapon.action.rpc_id(multiplayer.get_unique_id())


func primary_weapon_action_stop() -> void:
	if !is_multiplayer_authority()||!alive: return
	body.primary_weapon.stop_action.rpc_id(multiplayer.get_unique_id())
	
	
func secondary_weapon_action() -> void:
	if resource_tracker.energy < body.secondary_weapon.energy: return
	body.secondary_weapon.action.rpc_id(multiplayer.get_unique_id())


func mech_look_at(target_position: Vector2) -> void:
	if !is_multiplayer_authority()||!alive: return
	body.look_at(target_position)


#Health
func _on_hitbox_on_hit(hit_data) -> void:
	change_health(hit_data)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fall":
		hide()
		die(0,"Environment")


#Energy
func change_energy(amount:int)->void:
	print(resource_tracker.energy)
	resource_tracker.change_energy(amount)


func _on_death_timer_timeout() -> void:
	respawn.rpc()


func change_health(hit_data:Dictionary) -> void:
	resource_tracker.change_health.rpc(hit_data["amount"])
	if resource_tracker.health <= 0:
		die.rpc(hit_data["source_id"],hit_data["source_name"])


@rpc("any_peer","call_local")
func die(kill:int,kill_name:String) -> void:
	resource_tracker.energy_to_zero()
	alive = false
	$DefaultLegs.stop_legs()
	get_parent().add_death(player_id,kill,player_name,kill_name)
	body.primary_weapon.shooting = false
	toggle_collision()
	$DeathTimer.start()
	if is_multiplayer_authority():
		$CanvasLayer.show()
	$Explosion.play("explosion")
	apply_smoked_texture()

	
@rpc("any_peer","call_local")
func respawn() -> void:
	scale = Vector2(1,1)
	modulate = Color(1,1,1,1)
	alive = true
	resource_tracker.change_health(resource_tracker.max_health)
	position = main_path.get_random_spawn_point()
	toggle_collision()
	if is_multiplayer_authority():
		$CanvasLayer.hide()
	remove_smoked_texture()
	show()


func _on_explosion_animation_finished() -> void:
	$Explosion.animation = "default"


func apply_smoked_texture() -> void:
	$DefaultLegs.modulate = Color(0.2,0.2,0.2,1)
	$Body.modulate = Color(0.2,0.2,0.2,1)


func remove_smoked_texture() -> void:
	$Body.modulate = Color(1,1,1,1)
	$DefaultLegs.modulate = Color(1,1,1,1)


func toggle_collision() -> void:
	hitbox.set_collision_layer_value(6,!hitbox.get_collision_layer_value(6))
	set_collision_layer_value(5,!get_collision_layer_value(5))

@rpc("any_peer","call_local","reliable")
func overload():
	overloaded = true
	$OverloadTimer.start()
	body.modulate = Color(1, 0.5, 0.5, 1)
	#body.primary_weapon.overload_switch.rpc(overloaded)


func _on_overload_timer_timeout() -> void:
	resource_tracker.energy_to_zero()
	overloaded = false
	body.modulate = Color(1, 1, 1, 1)
	#body.primary_weapon.overload_switch.rpc(overloaded)

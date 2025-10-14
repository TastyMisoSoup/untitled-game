extends Node2D
class_name Body

var primary_weapon: PrimaryWeapon;
var secondary_weapon: SecondaryWeapon;


func _ready() -> void:
	var _energy

func primary_weapon_action(target_position) -> void:
	primary_weapon.action()
	primary_weapon.target_position = target_position

func primary_weapon_action_stop() -> void:
	primary_weapon.stop_action()

func set_primary_weapon(primary_weapon_str: String, self_hitbox:HurtBox) -> void:
	var weapon_scene;
	if ValidScenePaths.PRIMARY_WEAPONS.has(primary_weapon_str):
		weapon_scene = load("res://scenes/weapons/" + primary_weapon_str + ".tscn")
	else:
		weapon_scene = load("res://scenes/weapons/minigun.tscn")
	var weapon_instance = weapon_scene.instantiate()
	weapon_instance.position = $PrimaryWeaponPosMarker.position
	weapon_instance.self_hitbox = self_hitbox
	add_child(weapon_instance)
	primary_weapon = weapon_instance

func set_secondary_weapon(secondary_weapon_str: String, _self_hitbox:HurtBox) -> void:
	var weapon_scene;
	if ValidScenePaths.SECONDARY_WEAPONS.has(secondary_weapon_str):
		weapon_scene = load("res://scenes/weapons/" + secondary_weapon_str + ".tscn")
	else:
		weapon_scene = load("res://scenes/weapons/grenade-launcher.tscn")
	var weapon_instance = weapon_scene.instantiate()
	weapon_instance.position = $SecondaryWeaponPosMarker.position
	add_child(weapon_instance)

func set_mech_body(mech_body_str) -> Resource:
	if ValidScenePaths.MECH_BODIES.has(mech_body_str):
		return load("res://resources/stats/mechs/"+mech_body_str+".tres")
	else: 
		return load("res://resources/stats/mechs/daemon.tres")

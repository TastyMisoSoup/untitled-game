extends SecondaryWeapon
class_name GrenadeLauncher

const GRENADE_PATH:NodePath = "res://scenes/weapons/projectiles/grenade.tscn"

var weapon_ready = true
var weapon_cooldown:float = 0.4
	
	
func _ready() -> void:
	%WeaponCooldownIcon.max_value = weapon_cooldown


func _process(delta: float) -> void:
	%WeaponCooldownIcon.value = %WeaponCooldownIcon.max_value - $WeaponCooldown.time_left
	
	
@rpc("any_peer","call_local","reliable")
func action(current_energy:int) -> void:
	if !weapon_ready: return
	weapon_ready = false
	shoot.rpc($Muzzle.global_position,$Direction.global_position,0.8,GRENADE_PATH)
	spend_energy(energy)
	$WeaponCooldown.start(weapon_cooldown)


func show_icon() -> void:
	$CanvasLayer.show()


func _on_weapon_cooldown_timeout() -> void:
	weapon_ready = true

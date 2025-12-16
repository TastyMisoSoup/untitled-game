extends SecondaryWeapon
class_name GrenadeLauncher

const GRENADE_PATH:NodePath = "res://scenes/weapons/projectiles/grenade.tscn"
	
@rpc("any_peer","call_local","reliable")
func action() -> void:
	shoot.rpc($Muzzle.global_position,$Direction.global_position,0.8,GRENADE_PATH)
	spend_energy(energy)

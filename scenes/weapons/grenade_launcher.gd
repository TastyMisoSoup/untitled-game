extends SecondaryWeapon
class_name GrenadeLauncher

const GRENADE_PATH:NodePath = "res://scenes/weapons/projectiles/grenade.tscn"

const DAMAGE: float = 34
const SPEED: int = 800
	
func action() -> void:
	shoot($Muzzle.global_position,$Direction.global_position,1,GRENADE_PATH)

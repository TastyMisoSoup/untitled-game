extends SecondaryWeapon
class_name GrenadeLauncher

const GRENADE_PATH:NodePath = "res://scenes/weapons/projectiles/grenade.tscn"

const DAMAGE: float = 34
const SPEED: int = 800

@rpc("any_peer","call_local")
func shoot() -> void:
	var direction = Vector2($Direction.global_position - $Muzzle.global_position).normalized()
	

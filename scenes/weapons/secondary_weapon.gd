extends Weapon
class_name SecondaryWeapon

func spend_energy(energy:int):
	weapon_action.emit(-energy)

extends Control

const THEME_NORMAL:Theme = preload("res://scenes/ui-elements/themes/health_bar.tres")
const THEME_CRITICAL:Theme = preload("res://scenes/ui-elements/themes/health_bar_critical.tres")
	
func change_health(amount: float) -> void:
	$HealthBarLarge.value += amount
	$HealthBarLarge/HealthBarLargePercent.value += amount
	if($HealthBarLarge/HealthBarLargePercent.value / $HealthBarLarge/HealthBarLargePercent.max_value * 100 <= 35):
		$HealthBarLarge/HealthBarLargePercent.theme = THEME_CRITICAL
	else:
		$HealthBarLarge/HealthBarLargePercent.theme = THEME_NORMAL
	
func change_energy(amount: int) -> void:
	$EnergyBarLarge.value += amount
	$EnergyBarLarge/EnergyBarLargePercent.value += amount

func update_energy(new_max_energy:int) -> void:
	$EnergyBarLarge.max_value = new_max_energy
	$EnergyBarLarge/EnergyBarLargePercent.max_value = new_max_energy
	$EnergyBarLarge.value = 0
	$EnergyBarLarge/EnergyBarLargePercent.value = 0

func update_health(new_max_health: int) -> void:
	$HealthBarLarge.max_value = new_max_health
	$HealthBarLarge/HealthBarLargePercent.max_value = new_max_health
	$HealthBarLarge.value = new_max_health
	$HealthBarLarge/HealthBarLargePercent.value = new_max_health

func energy_to_zero() -> void:
	$EnergyBarLarge.value = 0
	$EnergyBarLarge/EnergyBarLargePercent.value = 0

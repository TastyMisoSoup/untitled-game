extends Health

func _ready() -> void:
	$HealthBarLarge.max_value = max_health
	$HealthBarLarge/HealthBarLargePercent.max_value = max_health
	$HealthBarLarge.value = max_health
	$HealthBarLarge/HealthBarLargePercent.value = max_health
	
func change_health(amount: float) -> void:
	super(amount)
	$HealthBarLarge.value += amount
	$HealthBarLarge/HealthBarLargePercent.value += amount

extends Area2D
class_name HurtBox
signal on_raycast_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if is_in_group("damage_type"):
		print("hi")
		
func raycast_hit(raycast: RayCast2D) -> void:
	on_raycast_hit.emit()

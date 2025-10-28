extends Area2D
class_name HurtBox
signal on_raycast_hit(amount: float)
signal fall_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_multiplayer_authority(multiplayer.get_unique_id())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

@rpc("authority","call_local")
func raycast_hit(amount: float) -> void:
	on_raycast_hit.emit(amount)

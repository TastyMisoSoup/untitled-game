extends CharacterBody2D
class_name Bullet

var damage: int
var start_position: Vector2
var direction: Vector2
var team: String
const SPEED: int = 600


func _ready() -> void:
	print(team)
	position = start_position
	look_at(global_position + direction)
	add_to_group(team)
	velocity = direction * SPEED

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") && !area.is_in_group(team):
		area.hit.rpc_id(1,-damage)
	queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()

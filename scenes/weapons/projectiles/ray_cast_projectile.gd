extends CharacterBody2D
class_name Bullet

var damage: int
var start_position: Vector2
var direction: Vector2
var team: String
var stopped: bool
const SPEED: int = 400


func _ready() -> void:
	print(team)
	position = start_position
	look_at(global_position + direction)
	add_to_group(team)
	velocity = direction * SPEED
	$Timer.start(randf_range(0.3,0.5))

func _physics_process(_delta: float) -> void:
	if stopped: return
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") && !area.is_in_group(team):
		area.hit.rpc_id(1,-damage)
	explode()

func explode() ->void:
	stopped = true
	$AnimatedSprite2D.play("explosion")

func _on_area_2d_body_entered(body: Node2D) -> void:
	explode()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	explode()

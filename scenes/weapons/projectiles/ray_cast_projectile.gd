extends Node2D
class_name RayCastProjectile
var deadzone: bool;
var target_position: Vector2;
var start_position: Vector2;
var one_shot: bool
var resource: Resource;
const PROJECTILE_SCENE = preload("res://scenes/weapons/projectiles/ray_cast_projectile.tscn")


static func projectile_construct(deadzone: bool,start_position:Vector2, target_position:Vector2):
	var projectile_instance = PROJECTILE_SCENE.instantiate()
	projectile_instance.deadzone = deadzone
	projectile_instance.start_position = start_position
	projectile_instance.target_position = target_position
	#projectile_instance.resource = resource
	return projectile_instance


func _ready() -> void:
	one_shot = true
	$Line2D.position = start_position
	$RayCast2D.position = start_position
	if(deadzone):
		$RayCast2D.set_target_position(target_position)
		$Line2D.set_point_position(1,target_position)
		#deadzone line2d and raycast2d pos needs to be reworked, the spread isnt wide enough
	else:
		$RayCast2D.set_target_position($RayCast2D.to_local(target_position))
		$Line2D.set_point_position(1,$Line2D.to_local(target_position))

func _process(delta: float) -> void:
	if $RayCast2D.is_colliding():	#checks if raycast hits, if so, deals damage
		var collision_point: Vector2 = $RayCast2D.get_collision_point()
		var collider = $RayCast2D.get_collider()
		$RayCast2D.enabled = false
		if collider.is_in_group("hurt_box") && !collider.is_in_group("team1"):
			collider.raycast_hit(-5)
		$Line2D.set_point_position(1,($Line2D.to_local(collision_point)))
	self.reparent(ProjectileManager)
	$Line2D.visible = true
	if one_shot:
		$AnimationPlayer.play("shoot")
	if !$AnimationPlayer.is_playing():
		queue_free()
	one_shot = false

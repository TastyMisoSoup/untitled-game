extends GutTest

var mech

func before_each():
	mech = Mech.new()

func test_velocity_normal():
	var vel = mech.compute_velocity(Vector2(1, 0), 1.0, false)
	assert_eq(vel, Vector2(200, 0))

func test_velocity_dash():
	var vel = mech.compute_velocity(Vector2(1, 0), 1.0, true)
	assert_almost_eq(vel, Vector2(200 * 2.4, 0),Vector2(0.0001, 0.0001))

func test_move_ignores_non_authority():
	mech.speed_modifier = 1.0
	mech.set_multiplayer_authority(9999) # fake someone else

	mech.move(Vector2(1,0))
	assert_eq(mech.velocity, Vector2.ZERO)

func test_health_equals_max_health_on_start():
	var health_node = Health.new()
	mech.health = health_node
	mech.health.max_health = 100
	mech.health.health = mech.health.max_health
	assert_eq(mech.health.health, mech.health.max_health)
	health_node.free()

func test_change_health_changes_correctly():
	var health_node = Health.new()
	mech.health = health_node
	mech.health.max_health = 100
	mech.health.health = mech.health.max_health
	mech.health.change_health(-20)
	assert_eq(health_node.health,health_node.max_health-20)
	health_node.free()

func after_each():
	mech.free()

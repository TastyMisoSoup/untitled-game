extends GutTest

var health_node: Node

func before_each():
	health_node = Health.new()

func test_health_equals_max_health():
	health_node.max_health = 100
	health_node.health = 100
	assert_eq(health_node.health,health_node.max_health)

func test_health_cant_be_higher_than_max():
	health_node.max_health = 100
	health_node.health = 999
	assert_eq(health_node.health, health_node.max_health)

func after_each():
	health_node.free()

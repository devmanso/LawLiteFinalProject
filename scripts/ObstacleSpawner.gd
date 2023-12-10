extends Node2D

onready var timer = $Timer
onready var sprite = $Icon
onready var current_scene = get_tree().current_scene
onready var legaldoc_timer = $LegalDocTimer

var rng = RandomNumberGenerator.new()
var obstacles = [
	load("res://Assets/TangledTape.tscn"),
	load("res://Assets/Wall.tscn"),
	load("res://Assets/LegalDocs.tscn")
	# Add other obstacle paths here
]

func _ready():
	rng.randomize()
	sprite.hide()
	legaldoc_timer.wait_time = rng.randf_range(7, 15)

func reset_wait_time(timer : Timer, rng : RandomNumberGenerator):
	timer.wait_time = rng.randf_range(7, 15)

func _process(delta):
	pass
#	if Engine.get_frames_per_second() > 60:
#		var legaldoc_instance = obstacles[2].instance()
#		legaldoc_instance.position = Vector2(999, 999)
#		get_tree().get_root().call_deferred("add_child", legaldoc_instance)

func determineObstaclePosition(obstacle : Node2D):
	if obstacle.name == "Wall":
		obstacle.position = position # walls must stay on the floor
	elif obstacle.name == "TangledTape":
		obstacle.position.y = rng.randf_range(200, 440)
		obstacle.position.x = position.x
	else:
		obstacle.position = Vector2(999, 999)

func _on_Timer_timeout():
	
	if obstacles.size() > 0:
		var obstacle_index = rng.randi_range(0, obstacles.size() -1)
		var obstacle_instance = obstacles[obstacle_index].instance()
#		obstacle_instance.position.y = rng.randf_range(200, 440)
#		obstacle_instance.position.x = position.x
		determineObstaclePosition(obstacle_instance)
		# we must make a deffered call of add_child at the root of the scene
		# so that obstacle_instance is not a child of ObstacleSpawner node
		# this must be done so that we can change the position of said
		# obstacle_instance
		get_tree().get_root().call_deferred("add_child", obstacle_instance)
	else:
		printerr("No obstacles in the array!")

func _on_LegalDocTimer_timeout():
	var legaldoc_instance = obstacles[2].instance()
	legaldoc_instance.position = Vector2(position.x, rng.randf_range(200, 440))
	get_tree().get_root().call_deferred("add_child", legaldoc_instance)
	reset_wait_time(legaldoc_timer, rng)

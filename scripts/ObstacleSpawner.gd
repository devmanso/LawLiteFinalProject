extends Node2D

onready var timer = $Timer
onready var sprite = $Icon

var rng = RandomNumberGenerator.new()
var obstacles = [
	load("res://Assets/TangledTape.tscn"),
	# Add other obstacle paths here
]

func _ready():
	rng.randomize()
	sprite.hide()

func _on_Timer_timeout():
	
	if obstacles.size() > 0:
		var obstacle_index = rng.randi_range(0, obstacles.size() - 1)
		var obstacle_instance = obstacles[obstacle_index].instance()
		obstacle_instance.position.y = rng.randf_range(200, 440)
		obstacle_instance.position.x = position.x
		
		# we must make a deffered call of add_child at the root of the scene
		# so that obstacle_instance is not a child of ObstacleSpawner node
		# this must be done so that we can change the position of said
		# obstacle_instance
		get_tree().get_root().call_deferred("add_child", obstacle_instance)
		
	else:
		printerr("No obstacles in the array!")
	
	

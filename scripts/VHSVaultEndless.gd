extends Node2D

var elapsedTime : float = 0.0
var speed_scale : int = 10

func _ready():
	elapsedTime = 0.0
	Engine.time_scale = 1

func clear():
	# queue_free() everything
	queue_free()

func _process(delta):
	# get how much time passed since the scene started
	# and store it inside a var
	elapsedTime += delta
	Engine.time_scale += ((elapsedTime /1000) /speed_scale)
	if speed_scale >=2:
		speed_scale =100
	

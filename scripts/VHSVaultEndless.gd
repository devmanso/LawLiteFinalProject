extends Node2D

onready var speed = $Speed

var elapsedTime : float = 0.0
var speed_scale : int = 10

func _ready():
	elapsedTime = 0.0
	Engine.time_scale = 1

func clear():
	for children in get_children():
		children.queue_free()
	queue_free()

func _process(delta):
	speed.text = str(Engine.time_scale)
	speed.text = speed.text.substr(0, 4)
	if Engine.time_scale <= 0:
		Engine.time_scale = abs(Engine.time_scale)
	# get how much time passed since the scene started
	# and store it inside a var
	elapsedTime += delta
	Engine.time_scale += ((elapsedTime /1000) /speed_scale)
	if speed_scale >=2:
		speed_scale =100
	

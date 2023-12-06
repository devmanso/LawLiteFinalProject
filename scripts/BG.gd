extends Node2D

onready var bg = $White

func _ready():
	bg.show()
	bg.scale = Vector2(100, 100) # make the BG super big

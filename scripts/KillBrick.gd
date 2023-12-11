extends StaticBody2D

onready var sprite = $Sprite

func _ready():
	sprite.hide()


func _on_BodyChecker_body_entered(body):
	if "Player" in body.name:
		get_tree().reload_current_scene()

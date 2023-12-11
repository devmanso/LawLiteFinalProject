extends Area2D

export var scene : String
var scenepath : String = "res://Levels/" + scene

func _on_TP_body_entered(body):
	get_tree().change_scene(scene)

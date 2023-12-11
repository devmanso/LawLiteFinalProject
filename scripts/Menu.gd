extends Node2D

func _ready():
	get_tree().change_scene("res://Levels/Desktop.tscn")

func _on_StartButton_pressed():
	get_tree().change_scene("res://Levels/Desktop.tscn")

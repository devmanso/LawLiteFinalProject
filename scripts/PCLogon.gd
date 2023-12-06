extends Node2D

onready var usernameField = $Username
onready var passwordField = $Password
onready var login = $LogInButton


func _on_LogInButton_pressed():
	get_tree().change_scene("res://Levels/Desktop.tscn")

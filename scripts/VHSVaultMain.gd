extends Node2D

onready var unlockables = $Unlockables


func _on_Play_pressed():
	get_tree().change_scene("res://Levels/VHSVaultEndless.tscn")

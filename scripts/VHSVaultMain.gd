extends Node2D

onready var unlockables = $Unlockables


func _on_Play_pressed():
	get_tree().change_scene("res://Levels/VHSVaultEndless.tscn")


func _on_Defense_pressed():
	var file = File.new()
	file.open("user://docscollected.txt", File.READ)
	print("reading")
	var line = file.get_line()
	var docs_collected = int(line)
	file.close()
	if docs_collected > 5:
		get_tree().change_scene("res://Levels/VHSVaultArguments.tscn")


func _on_Context_pressed():
	var file = File.new()
	print("reading")
	file.open("user://deaths.txt", File.READ)
	var line = file.get_line()
	var deaths = int(line)
	file.close()
	if deaths > 5:
		get_tree().change_scene("res://Levels/VHSVaultContext.tscn")


func _on_Decision_pressed():
	var file = File.new()
	print("reading")
	file.open("user://docscollected.txt", File.READ)
	var line = file.get_line()
	var docs_collected = int(line)
	file.close()
	if docs_collected > 10:
		get_tree().change_scene("res://Levels/VHSVaultDecision.tscn")


func _on_Impact_pressed():
	get_tree().change_scene("res://Levels/VHSVaultImpact.tscn")


func _on_GoBack_pressed():
	get_tree().change_scene("res://Levels/Desktop.tscn")

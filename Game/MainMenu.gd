extends Control


func _ready():
	pass

func _on_Button_Play_pressed():
	get_tree().change_scene("res://level selection.tscn")
	



func _on_Button_pressed():
	get_tree().quit()

extends Button

func _on_Play_pressed():
	get_tree().change_scene("res://scn/tests.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://scn/OptionsMenu.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://scn/MainMenu.tscn")

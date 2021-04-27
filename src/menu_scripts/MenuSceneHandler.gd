extends Button

func _on_Play_pressed():
	get_tree().change_scene("res://scn/tests.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://scn/menu_scenes/OptionsMenu.tscn")

func _on_Back_pressed():
	get_tree().change_scene("res://scn/menu_scenes/MainMenu.tscn")

func _on_Sound_pressed():
	get_tree().change_scene("res://scn/menu_scenes/SoundMenu.tscn")

func _on_Controls_pressed():
	get_tree().change_scene("res://scn/menu_scenes/ControlsMenu.tscn")

func _on_Video_pressed():
	get_tree().change_scene("res://scn/menu_scenes/VideoMenu.tscn")

func _on_Exit_pressed():
	get_tree().quit()

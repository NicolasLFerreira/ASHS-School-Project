extends Control

func _on_play_button_pressed():
	get_tree().change_scene("res://map/map_00.tscn");

func _on_settings_button_pressed():
	get_tree().change_scene("res://UI/settings_screen/settings_screen.tscn");

func _on_select_level_button_pressed():
	get_tree().change_scene("res://UI/level_selection_screen.tscn");

func _on_quit_button_pressed():
	get_tree().quit();

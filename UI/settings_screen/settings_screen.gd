extends Control

func _on_fullscreen_button_pressed():
	OS.window_fullscreen = !OS.window_fullscreen;

func _on_back_button_pressed():
	get_tree().change_scene("res://UI/title_screen/title_screen.tscn");

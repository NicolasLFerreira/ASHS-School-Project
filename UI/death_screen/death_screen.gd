extends Control

func _on_quit_button_pressed():
	get_tree().quit();

func _on_replay_button_pressed():
	get_tree().change_scene("res://map/map_00.tscn");

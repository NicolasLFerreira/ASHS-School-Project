extends Control

func _ready():
	
		
	$menu/bottom_row/buttons/level_1/button_text.text = "Level 1";
	$menu/bottom_row/buttons/level_2/button_text.text = "Level 2";
	$menu/bottom_row/buttons/level_3/button_text.text = "Level 3";
	$menu/bottom_row/buttons/level_4/button_text.text = "Level 4";
	$menu/bottom_row/buttons/level_5/button_text.text = "Level 5";
	$menu/bottom_row/buttons2/tutorial/button_text.text = "Tutorial";


func _on_level_1_pressed():
	get_tree().change_scene("res://map/map_00.tscn");

func _on_level_2_pressed():
	get_tree().change_scene("res://map/map_01.tscn");

func _on_level_3_pressed():
	get_tree().change_scene("res://map/map_02.tscn");


func _on_tutorial_pressed():
	get_tree().change_scene("res://map/map_00.tscn");

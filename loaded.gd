extends Node

func _process(delta):
	
	if (Input.is_action_just_pressed("f11")):
		OS.window_fullscreen = !OS.window_fullscreen;
	
	if (Input.is_action_just_pressed("q")):
		get_tree().quit();

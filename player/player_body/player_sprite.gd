extends Node2D

func _process(_delta):
	
	#Shortener
	
	var left = Input.is_action_pressed("left");
	var right = Input.is_action_pressed("right");
	var sneak = Input.is_action_pressed("down");
	var sprint = Input.is_action_pressed("shift");
	
	if (left):
		$player_sprite.play("running");
		$player_sprite.flip_h = true;
	
	if (right):
		$player_sprite.play("running");
		$player_sprite.flip_h = false;
	
	if (right and left):
		$player_sprite.play("idle");
	
	if (!right and !left):
		$player_sprite.play("idle");

extends KinematicBody2D

var speed = 100;
var vector = Vector2();
var gravity = 3;

func _physics_process(_delta):
	
	$enemy_sprite.play("running");
	
	vector = move_and_slide(vector, Vector2(0, -1));
	
	if (!is_on_floor()):
		vector.y += gravity;
	
	vector.x = speed;
	

func _on_turn_area_body_entered(_body):
	
	speed = -speed;
	
	$enemy_sprite.flip_h = !$enemy_sprite.flip_h;
	
	if (_body.get_name() == ("player_body")):
		if (_body.godmode == false):
			get_tree().change_scene("res://UI/death_screen/death_screen.tscn");

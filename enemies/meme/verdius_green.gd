extends KinematicBody2D

var speed = 50;
var vector = Vector2();
var gravity = 3;

var increase = 1;
var cap = 150;

func _physics_process(delta):
	
	$verdius_sprite.play("running");
	
	vector = move_and_slide(vector, Vector2(0, -1));
	
	if (!is_on_floor()):
		vector.y += gravity;
	
	vector.x = speed;
	
	increase = increase + 1;
	
	if (increase > cap):
			increase = 1;
			$verdius_sprite.flip_h = !$verdius_sprite.flip_h;
			speed = -speed;

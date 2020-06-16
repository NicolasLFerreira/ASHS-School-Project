extends Area2D

var flip = false;

func _ready():
	$spray_sprite.play();
	
	if (flip):
			$spray_sprite.flip_h = true;
	else:
		$spray_sprite.flip_h = false;
	

func _on_spray_time_timeout():
	queue_free();

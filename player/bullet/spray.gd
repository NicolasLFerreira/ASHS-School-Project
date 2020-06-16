extends Area2D

var flip = false;

func _ready():
	$spray_sprite.play();

func _process(delta):
	
	#Flip sprite
	
	if (flip):
		$spray_sprite.flip_h = true;
	if (!flip):
		$spray_sprite.flip_h = false;
	
	

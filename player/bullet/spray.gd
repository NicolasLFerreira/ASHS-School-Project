extends Area2D

export var exist = false;
export var flip = false;

func _ready():
	
	var rand_anim = rand_range(1,10);
	var anim = str(int(rand_anim));
	
	$spray_sprite.play(anim);
	$spray_time.start();

func _process(delta):
	
	#Flip sprite
	
	if (flip):
		$spray_sprite.flip_h = true;
	if (!flip):
		$spray_sprite.flip_h = false;

func _on_spray_time_timeout():
	
		queue_free();

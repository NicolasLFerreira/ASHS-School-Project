extends Area2D

export var speed = 300;
var direction = 0;
var durability = 2;
var isHorizontal = true;

var shoot = true;

func _ready():
	set_as_toplevel(true);

func _process(delta):
	if (isHorizontal):
		position.x += direction * speed * delta;
	else:
		position.y += direction * speed * delta;

func _on_bullet_body_entered(body):
	
	if (shoot):
		if body.is_a_parent_of(self):
			return;
		else:
			if (body.get_class() == "TileMap"):
				queue_free();
			else:
				body.queue_free();

func _on_view_camp_screen_exited():
	queue_free();

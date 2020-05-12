extends CanvasLayer

func _process(_delta):
	
	$stamina.set_text("Stamina: " + str(get_parent().get_node(".").stamina));
	

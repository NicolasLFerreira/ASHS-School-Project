extends KinematicBody2D

#Bullet

const bullet = preload("res://player/bullet/bullet.tscn");
var shoot = false;

#Movement

var move_speed = 15;
var jump_speed = -95;

#Physics

var gravity = 1.5;
var vector = Vector2();

var amount = 3;
var bouncing = -7;
var plus = 1;

var godmode = false;

#Stamina

var stamina_cap = 100;
var stamina = stamina_cap;
var stamina_cost = 5;
var stamina_regen = 4

var regen = false;

#Power/Skill

var power = true;
var power_vector = Vector2();

var dash = 500;

#Functions

##############
#Loop process#
##############

func _process(_delta):
	
	#Stamina fix
	
	if (stamina > stamina_cap):
		stamina = stamina_cap;
	
	#Function call


func _physics_process(_delta):
	
	#Function call
	
	_getInput();
	_godmode();
	_power();
	_skill();
	_shoot();
	
	#Floor and movement
	
	vector = move_and_slide(vector, Vector2(0, -1));
	power_vector = move_and_slide(power_vector, Vector2(0, -1));
	
	#Powervector
	
	power_vector.x = lerp(power_vector.x, 0, 0.2);
	
	
	#Gravity
	
	if (!godmode and !is_on_floor()):
		vector.y += gravity;
		power_vector.y += gravity;
	
	#Friction
	
	if is_on_floor():
		vector.x = lerp(vector.x, 0, 0.25);
	else:
		vector.x = lerp(vector.x, 0, 0.04);
	
	#Fall damage
	
	var die = false;
	
	if (vector.y > 250):
		die = true;
	
	if (is_on_floor()):
		if (die):
			get_tree().quit()
	

################
#Input Movement#
################

func _getInput():
	
	#Shortner variable
	
	var shift = Input.is_action_pressed("shift");
	var left = Input.is_action_pressed("left");
	var right = Input.is_action_pressed("right");
	var jump = Input.is_action_pressed("jump");
	
	#Movement input

	if (right):
		vector.x = min(vector.x+move_speed, move_speed * 4);
	
	if (left):
		vector.x = max(vector.x-move_speed, -move_speed * 4);
	
	#Jump
	
	if (is_on_floor()):
		if (jump):
			vector.y = jump_speed;
		
		#Boucing
		
		if (left or right):
			plus = plus + 1;
	
	if (plus > amount):
		plus = 0;
		vector.y = bouncing;
	
		#Slowdown
	
	if (Input.is_action_pressed("down")):
		move_speed = 1;
		amount = 10;
	else:
		if (!shift):
			move_speed = 15;
			amount = 3;
	

#########
#Stamina#
#########

func _on_stamina_regen_timeout():
	
	#Shortner variable
	
	var shift = Input.is_action_pressed("shift");
	var left = Input.is_action_pressed("left");
	var right = Input.is_action_pressed("right");
	
	#Regen
	
	if (stamina < stamina_cap):
		if !(shift and (right or left)):
			stamina += stamina_regen;

func _on_stamina_cost_timeout():
	
	#Shortner variable
	
	var shift = Input.is_action_pressed("shift");
	var left = Input.is_action_pressed("left");
	var right = Input.is_action_pressed("right");
	
	#Cost
	
	if (stamina >= stamina_cost and shift):
		
		move_speed = 25;
		
		if (left) or (right):
			stamina -= stamina_cost;
	else:
		move_speed = 15;

#######
#Shoot#
#######

func _shoot():
	
	if ($reload.get_time_left() == 0):
		if (Input.is_action_just_pressed("click1")):
			
			$reload.start();
			
			var bullet_instance = bullet.instance();
		
			add_child(bullet_instance);
			
			bullet_instance.global_position = global_position;
			bullet_instance.direction = -1 if $sprite_/player_sprite.flip_h else 1;
			bullet_instance.isHorizontal = true;

#######
#Skill#
#######

func _skill():
	
	#soapbomb
	
	if (Input.is_action_just_pressed("soapbomb")):
		vector.y = jump_speed;
		
		var bullet_instance = bullet.instance();
		
		add_child(bullet_instance);
		
		bullet_instance.global_position = global_position;
		bullet_instance.direction = 1;
		bullet_instance.isHorizontal = false;
	
	if (Input.is_action_just_pressed("dash")):
		power_vector.x += -dash if $sprite_/player_sprite.flip_h else dash;

#######
#Power#
#######

func _power():
	pass

#########
#Godmode#
#########

func _godmode():

	if (Input.is_action_just_pressed("godmode")):
		godmode = !godmode;
		vector.y = 0;
	
	if (godmode):
		if (Input.is_action_pressed("ui_up")):
			vector.y = -90;
		if (Input.is_action_pressed("ui_down")):
			vector.y = 90;
		vector.y = lerp(vector.y, 0, 0.25);

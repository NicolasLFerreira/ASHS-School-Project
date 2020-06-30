extends KinematicBody2D

#Bullet

const spray = preload("res://player/bullet/spray.tscn");

const bullet = preload("res://player/bullet/bullet.tscn");
var shoot = false;

#Movement

var move_speed = 15;
var jump_speed = -95;

#Physics

var gravity = 3;
var power_gravity = 2;
var vector = Vector2(0, 1);

var amount = 3;
var bouncing = -7;
var plus = 1;

var godmode = false;
var god_speed = 150;

#Stamina

var stamina_cap = 100;
var stamina = stamina_cap;
var stamina_cost = 5;
var stamina_regen = 4

var regen = false;
var stamina_toggle = true;

#Power/Skill

var power = 100;
const power_cap = 100;
const power_gen = 10;

var power_vector = Vector2();

var immortal = false;
var power_regen = false;

var dash = 500;

#Spray

var spray_amount = 3;
const spray_cap = 3;
const spray_gen = 1;

#Functions

##############
#Loop process#
##############

func _process(_delta):
	
	#Power fix
	
	if (power >= power_cap):
		power = power_cap;
		power_regen = true;
	
	if (power == power_cap):
		power_regen = true;
		$power_gen.stop();
	
	if (power < power_cap and power_regen):
		$power_gen.start();
		power_regen = false;
	
	#Stamina fix
	
	if (stamina == 0):
		stamina_toggle = false;
	
	if (stamina == stamina_cap):
		stamina_toggle = true;
	
	if (stamina > stamina_cap):
		stamina = stamina_cap;

func _physics_process(_delta):
	
	#Function call
	
	_getInput();
	_godmode();
	_skill();
	_shoot();
	_gui_content();
	
	#Floor and movement
	
	vector = move_and_slide(vector, Vector2(0, -1));
	power_vector = move_and_slide(power_vector, Vector2(0, -1));
	
	#Powervector
	
	power_vector.x = lerp(power_vector.x, 0, 0.2);
	
	#Gravity
	
	if (!godmode and !is_on_floor()):
		vector.y += gravity;
		power_vector.y = 0 ;
	
	#Friction
	
	if is_on_floor():
		vector.x = lerp(vector.x, 0, 0.25);
	else:
		vector.x = lerp(vector.x, 0, 0.04);

func _gui_content():
	
	$player_camera/GUI/items/power.text = "Power: " + str(power);
	$player_camera/GUI/items/stamina.text = "Stamina: " + str(stamina);
	

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
	
	if (is_on_floor() or is_on_ceiling()):
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
		if ((!shift and (!right or !left)) or !(stamina_toggle)):
			stamina += stamina_regen;

func _on_stamina_cost_timeout():
	
	#Shortner variable
	
	var shift = Input.is_action_pressed("shift");
	var left = Input.is_action_pressed("left");
	var right = Input.is_action_pressed("right");
	
	#Cost
	
	if (stamina_toggle):
		if (stamina >= 0 and shift):
			
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
		if (Input.is_action_pressed("shoot")):
			
			$reload.start();
			
			var bullet_instance = bullet.instance();
		
			add_child(bullet_instance);
			
			bullet_instance.global_position = global_position;
			bullet_instance.direction = -1 if $sprite_/player_sprite.flip_h else 1;
			bullet_instance.isHorizontal = true;

#######
#Skill#
#######

func _on_power_gen_timeout():
	
	if (power < power_cap):
		power += power_gen;

func _skill():
	
	#Soapbomb
	
	if (Input.is_action_just_pressed("soapbomb")):
		
		if (power >= 40):
			
			power -= 20;
			
			vector.y += jump_speed;
			
			var bullet_instance = bullet.instance();
			
			add_child(bullet_instance);
			
			bullet_instance.global_position = global_position;
			if ($sprite_/player_sprite.flip_v):
				bullet_instance.direction = -1;
			else:
				bullet_instance.direction = 1;
			bullet_instance.isHorizontal = false;
	
	#Dash
	
	if (Input.is_action_just_pressed("dash")):
		if (power >= 30):
			power -= 30;
			power_vector.x += -dash if $sprite_/player_sprite.flip_h else dash;
	
	#Ironskin
	
	if (Input.is_action_just_pressed("ironskin")):
		if (power >= 80):
			power -= 80;
			immortal = true;
			$immortal_time.start();
			$sprite_/player_sprite.flip_v = true;
	
	#Spray
	
	var spray_instance = spray.instance();
	
	if (Input.is_action_pressed("spray")):
		if (power >= 25):
			power -= 25;
			add_child(spray_instance);
			
			#Flip
			 
			if ($sprite_/player_sprite.flip_h):
				spray_instance.flip = true;
				spray_instance.global_position = global_position + Vector2(-10, -2)
				
			if (!$sprite_/player_sprite.flip_h):
				spray_instance.flip = false;
				spray_instance.global_position = global_position + Vector2(10, -2);

#Secondary skill related functions

func immortal_off():
	immortal = false;
	
	$sprite_/player_sprite.flip_v = false;

#########
#Godmode#
#########

func _godmode():
	
	if (Input.is_action_just_pressed("godmode")):
		godmode = !godmode;
		vector.y = 0;
	
	if (godmode):
		if (Input.is_action_pressed("ui_up")):
			vector.y = -god_speed;
		if (Input.is_action_pressed("ui_down")):
			vector.y = god_speed;
		vector.y = lerp(vector.y, 0, 0.25);

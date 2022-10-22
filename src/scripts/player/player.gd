extends KinematicBody2D

var base_speed = 250.0
var speed = 250.0
var velocity:Vector2 = Vector2.ZERO
var gravity = 25
var jump_strength = 600
var max_speed = 1000
var sprint_speed = 350.0

var can_move:bool


onready var label = $Label;

func _ready():
	can_move=true

func _physics_process(delta):
	if(can_move):
		move(delta)
		jump()
		sprint()
		label.text = "x_velocity: "+str(velocity.x)
	else: return
	


func get_input() -> Vector2:
	var dir_x = (
		(Input.get_action_strength("move_right")
	 - Input.get_action_strength("move_left"))
	)
	
	velocity.x = dir_x * speed
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	if(!is_on_floor()):
		velocity.y += gravity
		
	return velocity



func move(delta):
	velocity = move_and_slide(get_input(), Vector2.UP)

func jump():
	if(Input.is_action_pressed("jump") && is_on_floor()):
		velocity.y = -jump_strength

func sprint():
	if(Input.is_action_pressed("sprint") && is_on_floor()):
		speed = sprint_speed
	else:
		speed = base_speed


func _on_Grapple_hooked():
	can_move = false;

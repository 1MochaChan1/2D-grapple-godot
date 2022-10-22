extends Node2D

var mouse_pos:Vector2
var end_pos:Vector2
var player:KinematicBody2D
var is_hooked:bool = false
signal hooked

var t:float = 0

export var speed:float = .20

func _ready():
	set_process(true)
	mouse_pos = get_global_mouse_position()
	player = get_parent()
	end_pos = player.position
	

func _physics_process(delta):
	update()
	grapple()

func grapple():
	if(is_hooked):
		end_pos
	if(Input.is_action_pressed("action") && !is_hooked):
		end_pos = get_global_mouse_position()
		attach()
	elif(!is_hooked):
		end_pos = player.position
		attach()

func _draw():
	draw_line(to_local(player.position), to_local(global_position), Color.white, 1)
	
	
func attach(): 
	t=0
	t += speed
	global_position = global_position.linear_interpolate(end_pos, t)
	pass


func _on_Area2D_body_entered(body):
	if(body.is_in_group("Grappable")):
		is_hooked=true
		emit_signal("hooked")
		pass

extends RigidBody2D
var nosss: int = 0
var dir: float = 0.0
var thrust: float =  0.0
var tq_force: float = 8000.0
var tr_force: float = 2000.0
var speedmin: float = 1
var speedmax: float = 21.0
var acc: float = 0.05
signal nos
signal son
var speed: float
var speeed: float
var lap: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = speedmin

func _process(delta):
	dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	thrust = Input.get_action_strength("thrust") - Input.get_action_strength("back")
	
	var collide = get_colliding_bodies()
	
#	if  && thrust == 1:
#		speed = 1
#		speeed = log(pow(speed,3)+1.5)
#
	if thrust == 1 and speed < speedmax and collide == []:
		speed += acc
		speeed = log(pow(speed,3)+1.5)
	else:
		if speed > speedmin:
			speed -= acc
			speeed = log(pow(speed,3)+1.5)
	
#	print (angular_velocity)
#	if dir == 0 and angular_velocity != 0 :
#		if angular_velocity > 0:
#			angular_velocity = angular_velocity - 1/2*(angular_damp*angular_velocity)
#		elif angular_velocity < 0:
#			angular_velocity = angular_velocity + 1/2*(angular_damp*angular_velocity)
	if collide != []:
		speed = speedmin
		emit_signal("son")
	
	
	elif speed > 1:
		emit_signal("nos")
	
	$CanvasLayer/lap.text = "Lap: " + str(lap+1)
	$CanvasLayer/Speed.text = "speed: " + str(speed)
#	print(get_colliding_bodies())
#	print(tr_force)
#	print(dir)
#	print(thrust)

func _physics_process(delta):
	applied_force = (-global_transform.y * speeed/log(pow(speedmax,3)+1.5) * tr_force * thrust)
	applied_torque = (dir * tq_force)


func _on_End_finish():
	lap += 1
	if lap >= 3:
		get_tree().reload_current_scene()
	print(lap)
	
func _on_Player_nos():
	if $noss.playing == false:
		$noss.playing = true
	$Line2D.visible = true


func _on_Player_son():
	$Line2D.visible = false
	$noss.playing = false
	$noss.pitch_scale = 1

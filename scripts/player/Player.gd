extends KinematicBody

onready var animationPlayer = $Animation/AnimationPlayer

export var speed = 0.5

var motion = Vector3.ZERO

func _ready():
	animationPlayer.play("idleSouth")
#	animationPlayer.play("teste")

func run():
	if Input.is_action_pressed("north") and not Input.is_action_pressed("south"):
		motion.z = -speed/2
	elif Input.is_action_pressed("south") and not Input.is_action_pressed("north"):
		motion.z = speed/2
	else:
		motion.z = 0
	
	if Input.is_action_pressed("east") and not Input.is_action_pressed("west"):
		motion.x = speed
	elif Input.is_action_pressed("west") and not Input.is_action_just_pressed("east"):
		motion.x = -speed
	else:
		motion.x = 0
	motion = move_and_slide(motion,Vector3.UP)

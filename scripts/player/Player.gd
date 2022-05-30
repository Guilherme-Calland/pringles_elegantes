extends KinematicBody

onready var animationPlayer = $Animation/AnimationPlayer
onready var sprite = $Animation/Sprite
var orientation = "south"

export var speed = 0.5

var motion = Vector3.ZERO

func _ready():
	animationPlayer.play("idleSouth")

func run():
	if buttonPressed("north"):
		move("north")
	elif buttonPressed("south"):
		move("south")
	else:
		stop("vertical")
#
	if buttonPressed("east"):
		move("east")
	elif buttonPressed("west"):
		move("west")
	else:
		stop("horizontal")
	updateMotionVector()
	
	if buttonPressed("east"):
		sprite.flip_h = false
		if verticalButtonPressed():
			if buttonPressed("north"):
				animationPlayer.play("walkingDiagonalNorth")
				orientation = "diagonalNorth"
			elif buttonPressed("south"):
				animationPlayer.play("walkingDiagonalSouth")
				orientation = "diagonalSouth"
		else:
			animationPlayer.play("walkingHorizontal")
			orientation = "horizontal"
	elif buttonPressed("west"):
		sprite.flip_h = true
		if verticalButtonPressed():
			if buttonPressed("north"):
				animationPlayer.play("walkingDiagonalNorth")
				orientation = "diagonalNorth"
			elif buttonPressed("south"):
				animationPlayer.play("walkingDiagonalSouth")
				orientation = "diagonalSouth"
		else:
			animationPlayer.play("walkingHorizontal")
			orientation = "horizontal"
	else:
		if buttonPressed("north"):
			animationPlayer.play("walkingNorth")
			orientation = "north"
		elif buttonPressed("south"):
			animationPlayer.play("walkingSouth")
			orientation = "south"
	
	if isIdle():
		var animation = "idle" + orientation[0].to_upper() + str(orientation.trim_prefix(str(orientation[0])))
		animationPlayer.play(animation)

func isIdle():
	return motion.x == 0 && motion.z == 0

func buttonPressed(button):
	if button == 'north':
		return Input.is_action_pressed("north") and not Input.is_action_pressed("south")
	elif button == 'south':
		return Input.is_action_pressed("south") and not Input.is_action_pressed("north")
	elif button == 'east':
		return Input.is_action_pressed("east") and not Input.is_action_pressed("west")
	elif button == 'west':
		return Input.is_action_pressed("west") and not Input.is_action_pressed("east")

func move(inOrientation):
	if inOrientation == "north":
		motion.z = -speed
	elif inOrientation == "south":
		motion.z = speed
	elif inOrientation == "east":
		motion.x = speed
	elif inOrientation == "west":
		motion.x = -speed

func stop(inDirection):
	if inDirection == "horizontal":
		motion.x = 0
	elif inDirection == "vertical":
		motion.z = 0

func updateMotionVector():
	motion = move_and_slide(motion,Vector3.UP)

func verticalButtonPressed():
	return (buttonPressed("north") or buttonPressed("south"))

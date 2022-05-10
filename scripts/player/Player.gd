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
			checkWhatDiagonalAnimationShouldBePlayed()
		else:
			animationPlayer.play("walkingHorizontal")
	elif buttonPressed("west"):
		sprite.flip_h = true
		if verticalButtonPressed():
			checkWhatDiagonalAnimationShouldBePlayed()
		else:
			animationPlayer.play("walkingHorizontal")
	else:
		if buttonPressed("north"):
			animationPlayer.play("walkingNorth")
		elif buttonPressed("south"):
			animationPlayer.play("walkingSouth")
	
func buttonPressed(button):
	if button == 'north':
		return Input.is_action_pressed("north") and not Input.is_action_pressed("south")
	elif button == 'south':
		return Input.is_action_pressed("south") and not Input.is_action_pressed("north")
	elif button == 'east':
		return Input.is_action_pressed("east") and not Input.is_action_pressed("west")
	elif button == 'west':
		return Input.is_action_pressed("west") and not Input.is_action_pressed("east")

func checkWhatDiagonalAnimationShouldBePlayed():
	if buttonPressed("north"):
		animationPlayer.play("walkingDiagonalNorth")
	elif buttonPressed("south"):
		animationPlayer.play("walkingDiagonalSouth")

func move(orientation):
	if orientation == "north":
		motion.z = -speed
	elif orientation == "south":
		motion.z = speed
	elif orientation == "east":
		motion.x = speed
	elif orientation == "west":
		motion.x = -speed

func stop(direction):
	if direction == "horizontal":
		motion.x = 0
	elif direction == "vertical":
		motion.z = 0

func updateMotionVector():
	motion = move_and_slide(motion,Vector3.UP)

func verticalButtonPressed():
	return (buttonPressed("north") or buttonPressed("south"))

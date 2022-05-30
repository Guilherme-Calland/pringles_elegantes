extends WorldEnvironment

func _process(_delta):
	#change window size
#	OS.window_size = Vector2(512,300);
	
	$"/root".size = Vector2(512,300);
	$Player.run()

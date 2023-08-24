extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print ("Check wich languages is set")	
	var settings = ConfigFile.new()
	var err = settings.load("Settings.ini")

	if err != OK:
		print("Settings.ini not founded")
		return

	var _languages_seted = settings.get_value("Language","Default")
	print (_languages_seted) 
	self.text = _languages_seted

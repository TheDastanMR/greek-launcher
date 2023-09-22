extends Button
func _ready():
	self.text = tr("PLAY_BUTTON")
	
	
func _on_pressed():
	var _exe = "gbr.exe" #exe file of imperivm gbr
	OS.execute(_exe, [])
	get_tree().quit()

extends Button

func _on_pressed():
	var _exe = "gbr.exe" #exe file of imperivm gbr
	OS.execute(_exe, [])
	print("After Started .exe")
	get_tree().quit()

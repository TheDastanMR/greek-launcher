extends MenuButton

func _on_about_to_popup():
	
	print ("_on_pressed started")	
	var config = ConfigFile.new()
	var err = config.load("Settings.ini")

	if err != OK:
		print("not founded")
		return

	var _sections_settings = config.get_value("Language","Default")
	#var _language_settings_text = _language_settings.encode_to_text(language)
	print (_sections_settings)
	
	var _languages = self
	var _english = "English"
	config.set_value("Language", "Default",_english)
	config.save("Settings.ini")
	print (_sections_settings)

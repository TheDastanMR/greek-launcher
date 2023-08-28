extends OptionButton

var Languages = ["Italian","English","Spanish","Czech"]

func _ready():
	print("Language Started")
	var settings = ConfigFile.new()
	var err = settings.load("Settings.ini")
	
	if err != OK:
		print("not founded")
		return
		
	for l in Languages:
		add_item(l)	
		print("Founded languages:", l)
		
	var _selected_language = settings.get_value("Language","Default")
	print("Language selected:", _selected_language)

func _on_item_selected(index):
	print ("Language press")	
	var settings = ConfigFile.new()
	var err = settings.load("Settings.ini")
	var _selected_languge = get_item_text(index)
	
	if err != OK:
		print("Settings.ini not founded")
		return
		
	var _language_readed = settings.get_value("Language","Default")
	print("Language readed:",_language_readed)
	settings.set_value("Language", "Default",_selected_languge)
	settings.save("Settings.ini")
	print("Language writed:",_selected_languge)

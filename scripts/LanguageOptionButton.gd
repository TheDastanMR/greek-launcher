extends OptionButton

const LANGUAGES = ["English", "Italian", "Spanish", "Czech"]
const LANGUAGES_id = ["en","it","es","cs"]

func _ready():
	addLanguge()
	
	
func actualLanguagePosition(file, type):
	var langfile = FileAccess.open(file, FileAccess.READ)
	var lines = []
	
	while langfile.get_position() < langfile.get_length():
		lines.push_back(langfile.get_line())
	
	var CurrentLanguagePos
	for l in LANGUAGES:
		CurrentLanguagePos = lines.find(type+l,0)
		if (CurrentLanguagePos != -1):
			break
	return CurrentLanguagePos
	
	
func addLanguge():
	var settings = FileAccess.open("Settings.ini", FileAccess.READ)
	var lines = []
	
	while settings.get_position() < settings.get_length():
		lines.push_back(settings.get_line())
		
	var CurrentLanguage = lines[actualLanguagePosition("Settings.ini","Default=")]
	
	var i = 0
	var readedLanguage
	for l in LANGUAGES:
		add_item(l)	
		var combineDefaultLang = "Default="+l	
		if combineDefaultLang == CurrentLanguage:
			readedLanguage = l
			select(i)
			TranslationServer.set_locale(LANGUAGES_id[i])
			
		i += 1
	
	
func selectLanguage(file, type, index):
	var selected_file = FileAccess.open(file, FileAccess.READ)
	var file_lines = []
	var new_file_lines
	var selected_languge = get_item_text(index)
	
	while selected_file.get_position() < selected_file.get_length():
		file_lines.push_back(selected_file.get_line())
		

	file_lines[actualLanguagePosition(file,type)] = type+selected_languge
	file = FileAccess.open(file, FileAccess.WRITE)
	
	for i in file_lines:
		new_file_lines = String(i)
		file.store_line(new_file_lines)
	TranslationServer.set_locale(LANGUAGES_id[index])
	get_tree().change_scene_to_file("res://scenes/Launcher.tscn")
	
	
func _on_item_selected(index):
	selectLanguage("Settings.ini","Default=",index)
	selectLanguage("Data/CONST.INI","Language = ",index)
	
	

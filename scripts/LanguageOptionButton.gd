extends OptionButton

const LANGUAGES = ["English", "Italian", "Spanish", "Czech"]
const LANGUAGES_id = ["en","it","es","cs"]

func _ready():
	print("Language Started\n")
	addLanguge()
	
	
func actualLanguagePosition(file, type):
	#load file
	var langfile = FileAccess.open(file, FileAccess.READ)
	
	#crate a variabile for store all lines in file
	var lines = []
	
	#cicle in file and store everything in a array positions
	while langfile.get_position() < langfile.get_length():
		lines.push_back(langfile.get_line())
	
	#I made a search and a comparison for determinate which language is selected and return the position in file
	var CurrentLanguagePos
	for l in LANGUAGES:
		CurrentLanguagePos = lines.find(type+l,0)
		if (CurrentLanguagePos != -1):
			break
	return CurrentLanguagePos
	
	
func addLanguge():
	#load file
	var settings = FileAccess.open("Settings.ini", FileAccess.READ)
	
	#crate a variabile for store all lines in settings.ini
	var lines = []
	
	#cicle in settings.ini and store everything in a array positions
	while settings.get_position() < settings.get_length():
		lines.push_back(settings.get_line())
		
	#search in lines languages position and store
	var CurrentLanguage = lines[actualLanguagePosition("Settings.ini","Default=")]
	
	var i = 0
	var readedLanguage
	for l in LANGUAGES:
		add_item(l)	

		print("Founded languages:", l)
		var combineDefaultLang = "Default="+l
		
		if combineDefaultLang == CurrentLanguage:
			readedLanguage = l
			select(i)
			TranslationServer.set_locale(LANGUAGES_id[i])
			
		i += 1
	print("\nReaded language:",readedLanguage)
	print("Setted local language: ",TranslationServer.get_locale())
	
	
func selectLanguage(file, type, index):
	var selected_file = FileAccess.open(file, FileAccess.READ)
	var file_lines = []
	var new_file_lines
	var selected_languge = get_item_text(index)
	
	#Store in lines the line of the file
	while selected_file.get_position() < selected_file.get_length():
		file_lines.push_back(selected_file.get_line())
		
	
	#Replace the array language whit one i choose
	file_lines[actualLanguagePosition(file,type)] = type+selected_languge
	
		#Open the file and erase everything inside for write it.
	file = FileAccess.open(file, FileAccess.WRITE)
	
	#Iterate in var lines (where i store all content of the text file) and paste in opened file
	for i in file_lines:
		new_file_lines = String(i)
		file.store_line(new_file_lines)
	print ("Language select:",selected_languge)
	TranslationServer.set_locale(LANGUAGES_id[index])
	get_tree().change_scene_to_file("res://scenes/Launcher.tscn")
	
	
func _on_item_selected(index):
	selectLanguage("Settings.ini","Default=",index)
	selectLanguage("Data/CONST.INI","Language = ",index)
	
	

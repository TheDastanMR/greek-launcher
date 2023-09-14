extends CheckBox

func actualCinematicsFilePosition(file, type):
	#load file
	var cinematicfile = FileAccess.open(file, FileAccess.READ)
	
	#crate a variabile for store all lines in file
	var lines = []
	
	#cicle in file and store everything in a array positions
	while cinematicfile.get_position() < cinematicfile.get_length():
		lines.push_back(cinematicfile.get_line())
	
	#I made a search and a comparison for determinate which language is selected and return the position in file
	var CurrentCinematicsPos
	var state = ["true", "false"]
	
	for s in state:
		CurrentCinematicsPos = lines.find(type+s,0)
		if (CurrentCinematicsPos != -1):
			break
	return CurrentCinematicsPos
	
	
func _ready():
	var constini = FileAccess.open("Data/CONST.INI", FileAccess.READ)
	var lines = []
	var current_state
	
	while constini.get_position() < constini.get_length():
		lines.push_back(constini.get_line())
	
	current_state = lines[actualCinematicsFilePosition("Data/CONST.INI", "Cinematics = ")]
	
	if current_state == "Cinematics = true":
		set_pressed(true)
	if current_state == "Cinematics = false":
		set_pressed(false)
	
	
func _on_toggled(button_pressed):
	var file = "Data/CONST.INI"
	var constinifile = FileAccess.open(file, FileAccess.READ)
	var constinicinematics
	var lines = []
	var new_file_lines = []
	var cinematics_folder
	
	while constinifile.get_position() < constinifile.get_length():
		lines.push_back(constinifile.get_line())
	
	if button_pressed:
		
		constinicinematics = lines.find("Cinematics = false",0)
		if constinicinematics != -1:
			lines[constinicinematics] = "Cinematics = true"
		
		constinifile = FileAccess.open(file, FileAccess.WRITE)
		
		for i in lines:
			new_file_lines = String(i)
			constinifile.store_line(new_file_lines)
			
		cinematics_folder = DirAccess.rename_absolute("Movies","NoMovies")
	
	else:
		
		constinicinematics = lines.find("Cinematics = true",0)
		if constinicinematics != -1:
			lines[constinicinematics] = "Cinematics = false"
		
		constinifile = FileAccess.open(file, FileAccess.WRITE)
		
		for i in lines:
			new_file_lines = String(i)
			constinifile.store_line(new_file_lines)
			
		cinematics_folder = DirAccess.rename_absolute("NoMovies","Movies")

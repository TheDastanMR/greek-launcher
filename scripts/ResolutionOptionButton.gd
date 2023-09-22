extends OptionButton

var Resolutions: Dictionary = {
	"1024x768":Vector2i(1024,768),
	"1152x864":Vector2i(1152,864),
	"1280x720":Vector2i(1280,720),
	"1280x800":Vector2i(1280,800),
	"1366x768":Vector2i(1366,768),
	"1440x900":Vector2i(1440,900),
	"1600x900":Vector2i(1600,900),
	"1680x1050":Vector2i(1680,1050),
	"1920x1080":Vector2i(1920,1080)
	}
	
	
func _ready():
	addResolution()
	
	
func actualResolutionPosition(file, type):
	var resfile = FileAccess.open(file, FileAccess.READ)
	var lines = []
	
	while resfile.get_position() < resfile.get_length():
		lines.push_back(resfile.get_line())
		
	var CurrentRes
	var ix = 0
	var iy = 0
	for rx in Resolutions:
		var res = var_to_str(Resolutions[rx].x)
		CurrentRes = lines.find(type+res,0)
		if (CurrentRes != -1):
			return CurrentRes
		ix += 0
	for ry in Resolutions:
		var res = var_to_str(Resolutions[ry].y)
		CurrentRes = lines.find(type+res,0)
		if (CurrentRes != -1):
			return CurrentRes
		iy += 0
	
	
func addResolution():
	var config = FileAccess.open("Data/Interface/MENU/TEMPLATE.INI", FileAccess.READ)
	var lines = []
	
	while config.get_position() < config.get_length():
		lines.push_back(config.get_line())
		
	var CurrentResH = lines[actualResolutionPosition("Data/Interface/MENU/TEMPLATE.INI","Larghezza = ")]
	var CurrentResV = lines[actualResolutionPosition("Data/Interface/MENU/TEMPLATE.INI","Altezza = ")]
	
	var i = 0
	for r in Resolutions:
		add_item(r)
		var hRes = var_to_str(Resolutions.values()[i].x)
		var vRes = var_to_str(Resolutions.values()[i].y)
		
		var combineWindowX = "Larghezza = "+hRes
		var combineWindowY = "Altezza = "+vRes
		for r1 in Resolutions:
			if combineWindowX == CurrentResH:
				if combineWindowY == CurrentResV:
					select(i)
		i += 1
	
	
func selectResolution(file, typeH, typeV, index):
	var selected_file = FileAccess.open(file, FileAccess.READ)
	var file_lines = []
	var new_file_lines
	var selected_resolution_x = var_to_str(Resolutions.values()[index].x)
	var selected_resolution_y = var_to_str(Resolutions.values()[index].y)
	
	while selected_file.get_position() < selected_file.get_length():
		file_lines.push_back(selected_file.get_line())
		
	file_lines[actualResolutionPosition(file,typeH)] = typeH+selected_resolution_x
	file_lines[actualResolutionPosition(file,typeV)] = typeV+selected_resolution_y
	file = FileAccess.open(file, FileAccess.WRITE)
	
	for i in file_lines:
		new_file_lines = String(i)
		file.store_line(new_file_lines)
	
	
func _on_item_selected(index):
	selectResolution("Data/Interface/MENU/TEMPLATE.INI","Larghezza = ","Altezza = ",index)
	selectResolution("config.ini","WindowX = ","WindowY = ",index)
	selectResolution("Data/CONST.INI","Res1_x=","Res1_y=",index)

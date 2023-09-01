extends OptionButton

var default = "Default="

var Resolutions: Dictionary = {"1024x768":Vector2(1024,768),
								"1152x864":Vector2(1152,864),
								"1280x720":Vector2(1280,720),
								"1280x800":Vector2(1280,800),
								"1366x768":Vector2(1366,768),
								"1440x900":Vector2(1440,900),
								"1600x900":Vector2(1600,900),
								"1680x1050":Vector2(1680,1050),
								"1920x1080":Vector2(1920,1080)}

func _ready():
	print("Resolutions started")
	addResolution()
	fileAccess()

func addResolution():
	print("Founded resolutions:")
	for r in Resolutions:
		add_item(r)
		print(r)

func fileAccess():
	var file = FileAccess.open("0Settings.ini", FileAccess.READ_WRITE)
	var lines = []
	var test_lang = "Spanish"
	var str_lines
	while file.get_position()<file.get_length():
		lines.append(file.get_line())
		str_lines =  " ".join(lines)
		
	
	#print(lines[1])
	#file.store_string(str_lines)
	#lines[1] = str(default)+str(test_lang)
	#print(lines[1])
	var x = 0
	for i in lines:
		#print(i," ",x)
		print(str_lines[x])
		x += 1
		
func _on_item_selected(index):
	pass # Replace with function body.

#################################################
# @Author : Elisto								#
# @mail : elisto@protonmail.com				   	#	
# @Github : https://github.com/Elisto		   	#
#################################################

extends Node
# Declaring String that content Paths, if your lazy
const User_directory = "user://"
const Res_directory = "res://"
const Settings_Path = Res_directory + "Settings.cfg"

# 0 : File didn't open
# 1 : File open
enum {LOAD_ERROR_COULDNT_OPEN, LOAD_SUCCESS}


var config = ConfigFile.new()

# Dictionnary are very handy in this situation :
# Default Settings
var Settings = {
	"Display": 
	{
		"HEIGHT" : 900,
		"WIDTH" :1600,
		"FullScreen":false,
		"Vsync":true
	},
	"AUDIO":
	{
		"MUTE" : false,
		"MUSIC": 100,
		"GENERAL":100,
		"SOUND_EFFECTS":100
	}
}

func _ready():
	#Check if settings.ini exist if not create a new one with the default Settings
	if _load_Settings() == LOAD_ERROR_COULDNT_OPEN :
		_save_Settings()
	_apply_Settings()

func _load_Settings():
	# Check for error if true exist the function else parse the file and load the config settings into Settings
	var error = config.load(Settings_Path)
	if error != OK:
		print("Error loading the settings. Error code: %s" % error)
		return LOAD_ERROR_COULDNT_OPEN
	for section in Settings.keys():
		for key in Settings[section]:
			var val = config.get_value(section,key)
			Settings[section][key] = val
	return LOAD_SUCCESS

# Save the Settings into the config file if the config file dosen't exist create a new one
func _save_Settings():
	for section in Settings.keys():
		for key in Settings[section]:
			config.set_value(section,key,Settings[section][key])
	config.save(Settings_Path)

func _apply_Settings():
	# Check out the documentation about :
	# OS class : http://docs.godotengine.org/en/3.0/classes/class_os.html
	# Engine class : http://docs.godotengine.org/en/3.0/classes/class_engine.html
	# for this case i only use OS to change the resolution,fullscreen and Vsync 
	OS.window_size = Vector2(Settings.Display.WIDTH,Settings.Display.HEIGHT)
	OS.window_fullscreen = Settings.Display.FullScreen
	OS.vsync_enabled = Settings.Display.Vsync

# Only function that's call outside of this scripts
func update_Settings(H,W,Full,Audio,Mute,Vsync):
	Settings.Display.HEIGHT = H
	Settings.Display.WIDTH = W
	Settings.Display.FullScreen = Full
	Settings.Display.Vsync = Vsync
	Settings.AUDIO.GENERAL = Audio.x
	Settings.AUDIO.MUSIC = Audio.y
	Settings.AUDIO.SOUND_EFFECTS = Audio.z
	Settings.AUDIO.MUTE = Mute
	#Saving the file than applying it
	_save_Settings()
	_apply_Settings()



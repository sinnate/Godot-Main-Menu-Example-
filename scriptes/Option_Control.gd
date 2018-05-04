#################################################
# @Author : Elisto								#
# @mail : elisto@protonmail.com				   	#	
# @Github : https://github.com/Elisto		   	#
#################################################

extends Control
# Variables that match Settings in the singleton check out
# singleton/configuration.gd for more info

var Display = {"h" : 0,"w":0}
var Audio = Vector3()
var String_spliter
var Muted 
var fullscreen
var Vsync
func _ready():
	_update_settings()

func _update_settings():
	# Get the Settings for the singleton than load it the GUI
	get_node("LB_Video/CB_FS").pressed = configuration.Settings.Display.FullScreen
	get_node("LB_Video/CB_Vsync").pressed = configuration.Settings.Display.Vsync
	get_node("LB_Audio/CB_Mute").pressed = configuration.Settings.AUDIO.MUTE 
	get_node("LB_Audio/HS_General").value = configuration.Settings.AUDIO.GENERAL
	get_node("LB_Audio/HS_Music").value = configuration.Settings.AUDIO.MUSIC
	get_node("LB_Audio/HS_SE").value = configuration.Settings.AUDIO.SOUND_EFFECTS
	Display.h = configuration.Settings.Display.HEIGHT
	Display.w = configuration.Settings.Display.WIDTH
	Muted = get_node("LB_Video/CB_FS").pressed 
	fullscreen = get_node("LB_Audio/CB_Mute").pressed
	Audio = Vector3(configuration.Settings.AUDIO.GENERAL,configuration.Settings.AUDIO.MUSIC,configuration.Settings.AUDIO.SOUND_EFFECTS)
	Vsync = configuration.Settings.Display.Vsync
	_check_resolution()

func _check_resolution():
	# Get the count of the all the resolution in the items OptionButton 
	var NB = get_node("LB_Video/Option_Resolution").get_item_count()
	for i in NB:
		# Get the String in resolution that split in half e.g : 800x600 become two string :
		# String 0 : 800
		# String 1 : 600
		String_spliter = get_node("LB_Video/Option_Resolution").get_item_text(i)
		String_spliter = String_spliter.split("x")
		# Check if the two string are matching the display in the Settings than select in the OptionMenu
		if String_spliter[1] == String(configuration.Settings.Display.HEIGHT) && String_spliter[0] == String(configuration.Settings.Display.WIDTH):
			get_node("LB_Video/Option_Resolution").select(i)



# Get the resolution from the OptionMenu than load it into the Display variable
func _on_Option_Resolution_item_selected(ID):
	String_spliter = get_node("LB_Video/Option_Resolution").get_item_text(ID)
	String_spliter = String_spliter.split("x")
	Display.h = String_spliter[1]
	Display.w = String_spliter[0]



func _on_HS_General_value_changed(value):
	Audio.x = value


func _on_HS_Music_value_changed(value):
	Audio.y = value


func _on_HS_SE_value_changed(value):
	Audio.z = value


func _on_CB_Mute_toggled(button_pressed):
	Muted = button_pressed


func _on_CB_FS_toggled(button_pressed):
	fullscreen = button_pressed

# Call up the function in the singleton to update the settings
func _on_Button_Save_pressed():
	configuration.update_Settings(Display.h,Display.w,fullscreen,Audio,Muted,Vsync)


func _on_Button_Return_pressed():
	self.hide()


func _on_CB_Vsync_toggled(button_pressed):
	Vsync = button_pressed

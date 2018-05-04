#################################################
# @Author : Elisto								#
# @mail : elisto@protonmail.com				   	#	
# @Github : https://github.com/Elisto		   	#
#################################################

extends Control


func _ready():
	# Center the windows in the screen
	OS.window_position = (OS.get_screen_size()*0.5 - OS.window_size*0.5)


func _on_Button_Exit_pressed():
	# Exit the game
	get_tree().quit()


func _on_Button_Settings_pressed():
	# Show the Option Menu
	get_node("Option_Control").show()


func _on_Button_Start_pressed():
	# Load the sceance here
	pass

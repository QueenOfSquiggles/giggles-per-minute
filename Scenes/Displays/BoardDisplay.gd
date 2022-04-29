extends Control
"""
BoardDisplay.gd
---
The main display board for all cards available.
"""
class_name Board
export (NodePath) var context_menu_path : NodePath

onready var context_menu : Popup = get_node(context_menu_path)

var workspace_name := "default_workspace"
var board_name := "default_board"

func _ready() -> void:
	assert(context_menu, "Assign the context menu path to an appropriate PopupMenu node!")

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var btn := (event as InputEventMouseButton).button_index
		# 1 = lmb,2 = rmb, 3 = mmb
		match (btn):
			BUTTON_LEFT:
				_left_click(event)
			BUTTON_RIGHT:
				_right_click(event)
			BUTTON_MIDDLE:
				_middle_click(event)

func _left_click(_event : InputEventMouseButton) -> void:
	pass

func _middle_click(_event : InputEventMouseButton) -> void:
	pass

func _right_click(event : InputEventMouseButton) -> void:
	# on right click we want to open up the context menu
	var bounds := Rect2()
	bounds.position = event.position
	bounds.size = (context_menu as Control).rect_size
	(context_menu as Popup).popup(bounds);

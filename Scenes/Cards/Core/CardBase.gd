extends Control
class_name CardBase

onready var card_context_root := $CardOptions

var card_data := {}

var dragging := false
var drag_offset := Vector2()

func _ready() -> void:
	card_context_root.visible = false

func _on_CardPanel_gui_input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		match (event as InputEventMouseButton).button_index:
			BUTTON_LEFT:
				on_left_click(event)
			BUTTON_RIGHT:
				on_right_click(event)
			BUTTON_MIDDLE:
				on_middle_click(event)
	if event is InputEventMouseMotion and dragging:
		self.rect_global_position = (event as InputEventMouseMotion).global_position + drag_offset


func on_left_click(event : InputEventMouseButton) -> void:
	if event.doubleclick:
		print("This should open an inspector")
		pass
	elif event.pressed:
		drag_offset = self.rect_global_position - event.global_position
		request_drag_mode(true)
	else:
		request_drag_mode(false)
		drag_offset = Vector2()

func on_right_click(event : InputEventMouseButton) -> void:
	if event.pressed:
		# simple toggle for context
		card_context_root.visible = not card_context_root.visible

func on_middle_click(event : InputEventMouseButton) -> void:
	if event.pressed:
		print("Card [%s] middle click not implemented" % self.name)

func request_drag_mode(dragging_mode : bool) -> void:
	# extend for more complex logic for drag_mode 
	dragging = dragging_mode

func request_cursor_shape(shape : int) -> void:
	self.mouse_default_cursor_shape = shape

func _on_BtnDelete_pressed() -> void:
	call_deferred("queue_free")


func _on_BtnOpenInspector_pressed() -> void:
	print("Open inspector")

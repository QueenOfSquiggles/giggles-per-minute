extends PopupPanel

export (NodePath) var cards_root : NodePath

const DEFAULT_CARD = "CardBase"

func _on_BtnNewCard_pressed() -> void:
	var card := CardFactory.generate_new_card(DEFAULT_CARD)
	if card:
		get_node(cards_root).add_child(card)
		card.rect_global_position = self.rect_global_position
		self.hide()

func _on_BtnNewFolder_pressed() -> void:
	pass # Replace with function body.


func _on_BtnSearchAll_pressed() -> void:
	pass # Replace with function body.

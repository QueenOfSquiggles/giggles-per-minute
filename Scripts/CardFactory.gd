extends Node
"""
A factory for constructing new cards, given a string card type.
Cards are named with a standard package path style
'internal:list.todo' would translate to 'res://Scenes/Cards/Core/list/todo.tscn'
'CardsPack3:custom.fun' -> 'res://Assets/CardTypes/CardsPack3/custom/fun.tscn'
'list.todo' == 'internal:list.todo'
"""

const INTERNAL_CARDS_PATH := "res://Scenes/Cards/Core/"
const EXTERNAL_CARDS_PATH := "res://Assets/CardTypes/"

func generate_new_card(type : String) -> CardBase:
	"""
	Takes in the string type name of a valid class and returns a new instances of the card, not added to scene tree
	Returns null if unable to resolve card type
	"""
	if ":" in type:
		var tokens := type.split(":", false, 1)
		if tokens.size() != 2:
			return null
		var category = tokens[0]
		var card_type = tokens[1]
		if category.to_lower() == "internal":
			return _gen_new_card_internal(card_type)
		else:
			return _gen_new_card_external(category, card_type)
	return _gen_new_card_internal(type)

func _gen_new_card_internal(type : String) -> CardBase:
	var path = INTERNAL_CARDS_PATH + _convert_name_to_path(type)
	var card_scene := load(path) as PackedScene
	if card_scene:
		return card_scene.instance() as CardBase
	return null

func _gen_new_card_external(category : String, type : String) -> CardBase:
	var path = INTERNAL_CARDS_PATH + category + "/" + _convert_name_to_path(type)
	var card_scene := load(path) as PackedScene
	if card_scene:
		return card_scene.instance() as CardBase
	return null

func _convert_name_to_path(name : String) -> String:
	return name.replace('.', '/') + ".tscn"
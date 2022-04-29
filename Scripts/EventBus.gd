extends Node

signal serialize_board(board)

func trigger_serialize_board(board : Control) -> void:
	emit_signal("serialize_board", board)
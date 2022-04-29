extends Node

const WORKSPACE_ROOT := "user://workspaces/"
const META_DATA_PATH := "user://meta.json"

var meta_data := {
	"last-workspace" : "null",
	"last-board" : "null",
	"plugins" : [

	]
}

func get_last_workspace() -> String:
	return meta_data["last-workspace"]
func get_last_board() -> String:
	return meta_data["last-board"]
	
func _ready() -> void:
	var temp := read_json(META_DATA_PATH)
	if not temp.empty():
		meta_data = temp
	_load_all_plugins()
	EventBus.connect(serialize_board, self, "serialize_board")


func _load_all_plugins() -> void:
	for path in meta_data["plugins"]:
		_load_plugin(path)

func _load_plugin(pack_file : String) -> void:
	var pack_meta_file := pack_file + ".json"
	var pack_meta_data := read_json(pack_meta_file)
	if pack_meta_data.empty():
		push_error("Failed to load pack file [%s], loading meta data failed" % pack_file)
		return
	var preserve_existing :bool = pack_meta_data["preserve_existing"]
	var result = ProjectSettings.load_resource_pack(pack_file, preserve_existing)
	if result:
		print("Successfully loaded pack file : %s" % pack_file)
	else:
		push_error("Failed to load pack file [%s], error on loading from ProjectSettings")

func read_json(path : String) -> Dictionary:
	var file := File.new()
	var err := file.open(path, File.READ)
	if err == OK:
		var file_text := file.get_as_text()
		file.close()
		return parse_json(file_text)
	file.close()
	return {}

func write_json(path : String, data : Dictionary) -> void:
	var file := File.new()
	var _err = file.open(path, File.WRITE)
	var text := to_json(data)
	file.store_string(text)
	file.close()

func serialize_board(board : Board) -> void:
	var workspace := board.workspace_name
	var board_name := board.board_name
	# TODO create a serialization of "${workspace}/${board_name}.json" or something 
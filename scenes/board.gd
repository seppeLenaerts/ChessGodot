extends TileMapLayer
class_name Board

@export var pieces_tilemap : PiecesTileMap;
var dragging : bool = false;
var clicked_tile_location : Vector2i;
var active_piece : Piece;

var current_player : bool = Piece.WHITE

var white_score : int = 0
var black_score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _unhandled_input(event):
	if (event is InputEventMouseButton):
		var mouseEvent := event as InputEventMouseButton
		if (mouseEvent.button_index == MOUSE_BUTTON_LEFT):
			handle_mouse_click(mouseEvent)


func handle_mouse_click(mouseEvent : InputEventMouseButton):
	if (!dragging):
		clicked_tile_location = mouse_pos_to_tile()
		active_piece = pieces_tilemap.get_piece_by_location(clicked_tile_location)
		if (active_piece && active_piece.color != current_player):
			active_piece = null
	else:
		if (active_piece):
			if (is_legal_move()):
				active_piece.location = mouse_pos_to_tile()
				current_player = !current_player
			else:
				active_piece.location = clicked_tile_location
			active_piece = null;
		
	dragging = mouseEvent.is_pressed()


func mouse_pos_to_tile():
	return local_to_map(get_global_mouse_position());


func is_legal_move() -> bool:
	if (tile_occupied()):
		if capture_occupying_piece():
			return true
		return false
	else:
		return true


func tile_occupied() -> bool:
	return pieces_tilemap.get_piece_by_location(mouse_pos_to_tile()) != null


func capture_occupying_piece() -> bool:
	var captured_piece = pieces_tilemap.get_piece_by_location(mouse_pos_to_tile())
	if (captured_piece.color != active_piece.color):
		pieces_tilemap.capture_piece(captured_piece)
		return true
	else:
		return false

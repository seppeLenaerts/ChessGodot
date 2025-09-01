extends TileMapLayer
class_name PiecesTileMap

@export var board : Board;
var pieces : Array[Piece] = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i : Vector2i in get_used_cells():
		var tile_data = get_cell_tile_data(i);
		var piece : Piece = Piece.new();
		piece.color = tile_data.get_custom_data("WHITE");
		piece.type = tile_data.get_custom_data("TYPE");
		piece.location = i;
		piece.atlas_coords = get_cell_atlas_coords(i);
		piece.source = 24 if piece.color else 25
		pieces.append(piece);
	for i : Piece in pieces:
		print(i.type, i.location)

func get_piece_by_location(loc: Vector2i) -> Piece:
	for piece : Piece in pieces:
		if (piece.location == loc):
			return piece;
	return null;


func _process(_delta):
	clear()
	for p : Piece in pieces:
		_draw_piece(p)
	
	if (board.active_piece):
		_draw_piece(board.active_piece, board.mouse_pos_to_tile())


func _draw_piece(piece: Piece, location : Vector2i = Vector2i.MIN):
	if (location == Vector2i.MIN):
		set_cell(piece.location, piece.source, piece.atlas_coords)
	else:
		set_cell(location, piece.source, piece.atlas_coords)

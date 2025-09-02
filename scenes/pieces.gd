extends TileMapLayer
class_name PiecesTileMap

@export var board : Board;
var pieces : Array[Piece] = [];

func _ready() -> void:
	store_pieces_in_array()

func get_piece_by_location(loc: Vector2i) -> Piece:
	for piece : Piece in pieces:
		if (piece.location == loc):
			return piece;
	return null;


func _process(_delta):
	clear()
	for p : Piece in pieces:
		draw_piece(p)


func draw_piece(piece: Piece):
	set_cell(piece.location, piece.source, piece.atlas_coords)

func store_pieces_in_array():
	for i : Vector2i in get_used_cells():
		var tile_data = get_cell_tile_data(i);
		var piece : Piece = Piece.new();
		piece.color = tile_data.get_custom_data("WHITE");
		piece.type = tile_data.get_custom_data("TYPE");
		piece.location = i;
		piece.atlas_coords = get_cell_atlas_coords(i);
		piece.source = 24 if piece.color else 25
		piece.points = get_points_for_type(piece.type)
		pieces.append(piece);


func get_points_for_type(type:String):
	match type:
		"QUEEN":
			return 9
		"ROOK":
			return 5
		"KNIGHT", "BISHOP":
			return 3
		"PAWN":
			return 1
		"KING":
			return 999999999


func capture_piece(piece: Piece):
	pieces.erase(piece)
	if (piece.color == piece.BLACK):
		board.white_score += piece.points
	else:
		board.black_score += piece.points
	
	print("Black: ", board.black_score)
	print("White: ", board.white_score)
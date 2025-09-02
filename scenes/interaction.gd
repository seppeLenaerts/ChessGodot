extends TileMapLayer

@export var board : Board

func _process(_delta):
	clear()
	if (board.active_piece):
		_draw_piece(board.active_piece, board.mouse_pos_to_tile())


func _draw_piece(piece: Piece, location : Vector2i = Vector2i.MIN):
	set_cell(location, piece.source, piece.atlas_coords)

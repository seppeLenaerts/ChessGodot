extends AnimatedSprite2D

@export var board : Board;

func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	var active_piece = board.active_piece
	if (active_piece):
		animation = "white" if active_piece.color else "black"
		match active_piece.type:
			"QUEEN":
				frame = 4
			"ROOK":
				frame = 5
			"KNIGHT":
				frame = 2
			"BISHOP":
				frame = 0
			"PAWN":
				frame = 3
			"KING":
				frame = 1
		show()
		position = get_global_mouse_position()
	else:
		hide()

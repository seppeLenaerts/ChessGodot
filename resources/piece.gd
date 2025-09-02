extends Resource
class_name Piece

const WHITE = true;
const BLACK = false;

var location : Vector2i;
var color : bool;
var type : String;
var points : int;

var source : int;
var atlas_coords : Vector2i;
extends TileMap

func _ready():
    pass # Replace with function body.


func generate(cx, cy, len_):
    for x in range(len_ / 2):
        for y in range(len_ / 2):
            set_cell(len_ / 4 + x, len_ / 4 + y, 0)


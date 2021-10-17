using Godot;

//yeah right naming it TileMap atleast name it MyTileMap
//name overlapping is nono in C#
public class MyTileMap : TileMap
{
    //export the noise so that you can set it in the editor not in the code
    [Export] OpenSimplexNoise Noise;
    //have to set rng as a variable (you should do that in gdscript aswell)
    RandomNumberGenerator rng;

    Vector2 lastTile = Vector2.Zero;

    //also stop fucking leaving func _ready(): pass thing
    //remove it if its useless
    //or put todo comment in it

    public override void _Input(InputEvent @event)
    {
        //mouse in viewport coord
        if (@event is InputEventMouseMotion iemm) MoveSelection();
    }

    public void MoveSelection()
    {
        var pos = WorldToMap(GetGlobalMousePosition());
        if (lastTile != pos)
        {
            //implicit casting cringe and C# disables implicit casting from simple to complex types
            var cell = GetCell((int)pos.x, (int)pos.y);
            var lastCell = GetCell((int)lastTile.x, (int)lastTile.y);

            SetCell((int)lastTile.x, (int)lastTile.y, lastCell - 6);

            lastTile = pos;
            SetCell((int)pos.x, (int)pos.y, cell + 6);
        }
    }

    //test function
    //swap the function if you want random terrain
    //also idfk whats the random in this
    public void Generate(int cx, int cy, int len)
    {
        for (int x = 0; x < len; x++)
            for (int y = 0; y < len; y++)
                SetCell(x, y, 5 * x / len);
    }
    //wtf does that mean????
    public void GenerateActually(int cx, int cy, int len)
    {
        //terrain generation
        //checking for existing tiles
        if (GetCell(cx, cy) >= 0) return;
        SetCell(cx, cy, 0);

        Noise.Seed = (int)rng.Randi();

        for (int x = 0; x < len; x++)
        {
            for (int y = 0; y < len; y++)
            {
                //store these in vars so that you dont have to do the operation twice
                var x1 = x + cx * 32;
                var y1 = y + cy * 32;

                SetCell(x1, y1, (int)Noise.GetNoise2d((float)x1, (float)y1) * 3 + 3);
            }
        }
    }
}
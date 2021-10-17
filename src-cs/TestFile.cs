using Godot;

public class TestFile : Node2D
{
    [Export] NodePath ResourceTileMapPath;
    [Export] NodePath TileMapPath;

    ResourceTileMap _resourceTileMap;
    MyTileMap _tileMap;
    RandomNumberGenerator _rng;

    public override void _Ready()
    {
        _resourceTileMap = GetNode(ResourceTileMapPath) as ResourceTileMap;
        _tileMap = GetNode(TileMapPath) as MyTileMap;

        //var world = LoadWorld();
        //world is false for now as we dont want saving and loading
        var world = false;
        if (!world)
        {
            _rng.Randomize();
            _tileMap.Generate(0, 0, 128); //instead of tilemap.generate
            _resourceTileMap.Generate(0, 0, 128);
        }
    }
    public void SaveWorld()
    {
        var saveFile = new File();
        saveFile.Open("user://saved.map", File.ModeFlags.Write);

        //GetusedCells return Array which returns object when iterating
        //object can be casted to any type it currently holds (its like void pointer but more op)
        //implicit casting to vector2 would do the trick
        //it will throw some exception when object isnt vector2 but i dont think godot will return non vector2 in this case
        foreach (Vector2 c in _tileMap.GetUsedCells())
        {
            saveFile.StoreDouble((double)c.x);
            saveFile.StoreDouble((double)c.y);
        }
    }
    public bool LoadWorld()
    {
        var saveFile = new File();

        if (!saveFile.FileExists("user://saved.map")) return false;
        saveFile.Open("user://saved.map", File.ModeFlags.Read);

        while (saveFile.GetPosition() != saveFile.GetLen())
        {
            var c = new Vector2(
                (float)saveFile.GetDouble(),
                (float)saveFile.GetDouble()
            );

            _tileMap.SetCellv(c, 0);

            for (int x = 0; x < 32; x++)
                for (int y = 0; y < 32; y++)
                    _tileMap.SetCell(x + (int)c.x * 32, y + (int)c.y * 32, saveFile.Get8());
        }

        return true;
    }
}
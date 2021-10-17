using Godot;
using System;

public class TestFile : Node2D
{
    [Export] NodePath ResourceTileMapPath;
    [Export] NodePath TileMapPath;

    ResourceTileMap resourceTileMap;
    MyTileMap tileMap;
    RandomNumberGenerator rng;

    public override void _Ready()
    {
        resourceTileMap = GetNode(ResourceTileMapPath) as ResourceTileMap;
        tileMap = GetNode(TileMapPath) as MyTileMap;

        //var world = LoadWorld();
        //world is false for now as we dont want saving and loading
        var world = false;
        if (!world)
        {
            rng.Randomize();
            tileMap.Generate(0, 0, 128); //instead of tilemap.generate
            resourceTileMap.Generate(0, 0, 128);
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
        foreach (Vector2 c in tileMap.GetUsedCells())
        {
            saveFile.StoreDouble((double)c.x);
            saveFile.StoreDouble((double)c.y);
        }
    }
    public bool LoadWorld()
    {
        var saveFile = new File();

        if (!saveFile.FileExists("user://saved.map")) return false;
        var err = saveFile.Open("user://saved.map", File.ModeFlags.Read);

        if (err != Error.Ok) throw new Exception($"Error while opening file \"user://saved.map\"\n{err}");

        while (saveFile.GetPosition() != saveFile.GetLen())
        {
            var c = new Vector2(
                (float)saveFile.GetDouble(),
                (float)saveFile.GetDouble()
            );

            tileMap.SetCellv(c, 0);

            for (int x = 0; x < 32; x++)
                for (int y = 0; y < 32; y++)
                    tileMap.SetCell(x + (int)c.x * 32, y + (int)c.y * 32, saveFile.Get8());
        }

        return true;
    }
}
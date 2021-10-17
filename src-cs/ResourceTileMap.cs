using Godot;

public class ResourceTileMap : TileMap
{
    public void Generate(int cx, int cy, int len)
    {
        for (int x = 0; x < len / 2; x++)
            for (int y = 0; y < len / 2; y++)
                SetCell(len / 4 + x, len / 4 + y, 0);
    }
}
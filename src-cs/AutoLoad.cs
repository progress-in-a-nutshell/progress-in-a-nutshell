using Godot;

public class AutoLoad : Node
{
    float _gravity = 80f;
    //default save stats or smth
    //Dictionary<string, int> stats = new Dictionary<string, int>
    //{
    //    {"hp", 1},
    //    {"xp", 1}
    //};
    //cant cast string to dictitionary
    string _stats;

    public void Save(string saveDict)
    {
        var saveGame = new File();
        saveGame.StoreLine(saveDict);
        saveGame.Close();
    }
    public void Load()
    {
        var saveGame = new File();

        if (!saveGame.FileExists("user://savegame.save")) return;

        saveGame.Open("user://savegame.save", File.ModeFlags.Read);

        _stats = saveGame.GetAsText();
    }
}

using Godot;
using System;
using System.Collections.Generic;

public class AutoLoad : Node
{
    float gravity = 80f;
    //default save stats or smth
    //Dictionary<string, int> stats = new Dictionary<string, int>
    //{
    //    {"hp", 1},
    //    {"xp", 1}
    //};
    //cant cast string to dictitionary
    string stats;

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
        stats = saveGame.GetAsText();
    }
}

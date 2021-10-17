using Godot;

public class Play : Button
{
    //whoever named the function in Play.gd should take a long look in the mirror and ask yourself
    //"why did i name it like that"
    //cuz wtf is _on_Play_pressed bullshit?
    //how many naming convention are ya gonna fucking mix

    //also inline functions are awesome
    public void OnPlayPressed() => GetTree().ChangeScene("res://scn/tests.tscn");
}

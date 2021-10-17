using Godot;

public class Camera : Camera2D
{
    [Export] float CamSpeed = 720f;
    //[Export] float accelerateTime = 0.125f;
    //[Export] float deaccelerateTime = 0.15f;

    const float _scrollLim = 0.1f;
    const float _minZoom = 1f;
    const float _maxZoom = 100f;

    //because primitive types only can be constant in C#
    static readonly Vector2 Zoomcam = new Vector2(_scrollLim, _scrollLim);

    public override void _Process(float delta)
    {
        //camera motion control VERY unoptimized
        //cant cast to int because welcome to C# haha
        //might be something to do with bool might be any random value not just 1 or 0
        Position += new Vector2(
            (float)((Input.IsActionPressed("ui_right") ? 1 : 0) - (Input.IsActionPressed("ui_left") ? 1 : 0)),
            (float)((Input.IsActionPressed("ui_up") ? 1 : 0) - (Input.IsActionPressed("ui_down") ? 1 : 0))
        ).Normalized() * CamSpeed * Zoom * delta;
    }
    public override void _Input(InputEvent @event)
    {
        //because Zoom is not a variable, its a property with get set function
        //sort of like GetZoom() SetZoom() together
        var zoom = Zoom;

        //cam zooming for normie mouse
        if (@event is InputEventMouseButton iemb)
        {
            //we dont need match or enum fuck you
            if (iemb.IsPressed())
            {
                if (iemb.ButtonIndex == (int)ButtonList.WheelUp) zoom -= Zoomcam;
                else if (iemb.ButtonIndex == (int)ButtonList.WheelDown) zoom += Zoomcam;
            }
        }
        //for touchpads
        else if (@event is InputEventPanGesture iepg)
        {
            if (iepg.Delta.y > 0f) zoom -= Zoomcam;
            else if (iepg.Delta.y < 0f) zoom += Zoomcam;
        }

        //zoom limit
        zoom.x = Mathf.Clamp(Zoom.x, _minZoom, _maxZoom);
        zoom.y = Mathf.Clamp(Zoom.y, _minZoom, _maxZoom);

        //set the variable
        Zoom = zoom;
    }
}

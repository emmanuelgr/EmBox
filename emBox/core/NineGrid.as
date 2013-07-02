package emBox.core{
import flash.geom.Point;

public class NineGrid {
  public static const TopLeft:String = "TopLeft";
  public static const TopMiddle:String = "TopMiddle";
  public static const TopRight:String = "TopRight";
  public static const MiddleLeft:String = "MiddleLeft";
  public static const MiddleMiddle:String = "MiddleMiddle";
  public static const MiddleRight:String = "MiddleRight";
  public static const LowerLeft:String = "LowerLeft";
  public static const LowerMiddle:String = "LowerMiddle";
  public static const LowerRight:String = "LowerRight";
  static private var uv:Point;

  static public function regPoint(alignment:String ):Point {
    uv = new Point();

    switch (alignment){
      case "TopLeft":
        uv.x =  0;
        uv.y =  0;
      break;
      case "TopMiddle":
        uv.x =  0.5;
        uv.y =  0;
      break;
      case "TopRight":
        uv.x =  1;
        uv.y =  0;
      break;
      case "MiddleLeft":
        uv.x =  0;
        uv.y =  0.5;
      break;
      case "MiddleMiddle":
        uv.x =  0.5;
        uv.y =  0.5;
      break;
      case "MiddleRight":
        uv.x =  1;
        uv.y =  0.5;
      break;
      case "LowerLeft":
        uv.x =  0;
        uv.y =  1;
      break;
      case "LowerMiddle":
        uv.x =  0.5;
        uv.y =  1;
      break;
      case "LowerRight":
        uv.x =  1;
        uv.y =  1;
      break;
      default:
        var array:Array = alignment.split(",")
        uv.x =  parseFloat( array[0] );
        uv.y =  parseFloat( array[1] );
    }
    return uv;
  }

}

}
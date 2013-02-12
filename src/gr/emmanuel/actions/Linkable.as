package gr.emmanuel.actions {
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.net.navigateToURL;
import flash.net.URLRequest;

/**
 * ...
 * @author Emmanuel Vohaitis
 */
public class Linkable extends Interactivable {
  /**
   * @param SELF "_self" specifies the current frame in the current window.
   * @param BLANK "_blank" specifies a new window.
   * @param PARENT "_parent" specifies the parent of the current frame.
   * @param TOP "_top" specifies the top-level frame in the current window.
   */
  public static const SELF:String="_self";
  public static const BLANK:String="_blank";
  public static const PARENT:String="_parent";
  public static const TOP:String="_top";
  private var _url:String;
  
  public function Linkable(
  icon:InteractiveObject,
  url:String,
  onDown:Function = null,
  onUp:Function = null,
  onOver:Function = null,
  onOut:Function = null
  ) {
    this.url = url;
    super(icon, onClick, null, onDown, onUp, onOver, onOut);
  }
  
  private function onClick(event:MouseEvent = null):void{
    var request:URLRequest = new URLRequest(url);
    try  {	navigateToURL(request, BLANK);}
    catch (e:Error) 	{ trace("Error occurred!"); }
  }

  public function get url():String {    return _url;  }
  public function set url(value:String):void {
    if (!value) return;
    _url = (value.indexOf("http://")==-1)? "http://" + value:value;
  }
  
}
}
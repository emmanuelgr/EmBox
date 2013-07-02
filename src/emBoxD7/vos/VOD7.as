package emBoxD7.vos {
import emBox.dataObjects.*;
import emBox.interfaces.IHref;
import emBox.interfaces.IPath;
import emBox.utils.Objects;
import emBox.vos.VO;
import emBox.interfaces.IPath;
import emBoxD7.dataObjects.StringI18n;

public class VOD7 extends VO implements IPath, IHref {
	
  public var mlid:String = "";
	public var title:String = "";
	private var _path:String = "";
  private var _href:String = "";
	
	public function VOD7(rawData:Object){
		super(rawData);
		
		type = Objects.getValue(rawData, "type");
    _href = Objects.getValue(rawData, "href");
		_path = Objects.getValue(rawData, "path");
		mlid = Objects.getValue(rawData, "mlid");
		title = Objects.getValue(rawData, "title");
	}
  
  public function get path():String {    return _path;  }
  public function set path(value:String):void {
    _path = value;
  }  
  public function get href():String {    return _href;  }
  public function set href(value:String):void {
    _href = value;
  }  
}
}


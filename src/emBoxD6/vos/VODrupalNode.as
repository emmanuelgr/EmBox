package emBoxD6.vos {
import emBox.dataObjects.*;
import emBox.utils.Objects;
import emBox.vos.VO;

public class VODrupalNode extends VO{
	
	public var nid:String = "";
	public var title:String = "";
	public var body:String = "";
	public var teaser:String = "";
	public var language:String = "";
	public var href:String = "";
	public var taxonomy:Object = {};
	public var nodeHierarchy:Array = [];
  public var _path:String = "";
	
	public function VODrupalNode(rawData:Object){
		super(rawData);
		_path = Objects.getValue(rawData, "path");
		type = Objects.getValue(rawData, "type");
		nid = Objects.getValue(rawData, "nid");
		href = Objects.getValue(rawData, "href");
		language = Objects.getValue(rawData, "language")||"";
		title = Objects.getValue(rawData, "title");
		body = Objects.getValue(rawData, "body")||"";
		body = body.split("\r").join("");
		teaser = Objects.getValue(rawData, "teaser")||"";
		teaser = teaser.split("\r").join("");
		
    if (rawData.hasOwnProperty("taxonomy")){
      for(var key:String in rawData.taxonomy){
        var aVoTaxonomy:VODrupalNodeTaxonomyTerm = new VODrupalNodeTaxonomyTerm(
        Objects.getValue(rawData.taxonomy[key], "name"),
        Objects.getValue(rawData.taxonomy[key], "tid"),
        Objects.getValue(rawData.taxonomy[key], "vid"),
        Objects.getValue(rawData.taxonomy[key], "description"),
        parseInt(Objects.getValue(rawData.taxonomy[key], "weight"))
        );
        taxonomy[key] = aVoTaxonomy;
      }
		}
	}
  
  /* INTERFACE emBoxD6.interfaces.IPath */
  
  public function get path():String {
    return _path;
  }
  
  public function set path(value:String):void {
    _path = value;
  }
}
}


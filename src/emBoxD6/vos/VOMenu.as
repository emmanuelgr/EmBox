package emBoxD6.vos {
  import emBox.interfaces.IHref;
  import emBox.utils.Objects;
  import emBox.vos.VO;
  import emBox.interfaces.IPath;

  public class VOMenu extends VO implements IPath, IHref {
	public var mlid:String = ""; //The menu link id.
	public var plid:String = ""; //The mlid of the parent.
	public var title:String = "";
	public var description:String = "";
	public var expanded:Boolean;
	public var external:Boolean;
	public var has_children:Boolean;
	public var hidden:Boolean;
	public var weight:int;
	public var depth:int;
	public var papa:VOMenu;
	public var children:Array = [];
	public var page_callback:String = "";
	public var optionsAttributes:Object = { };
	public var langcode:String = "";
	public var attributeID:String = "";
	public var ref_nids:Array = [];
	public var ref_types:Array = [];
	public var ref_nid:String = "";
	public var ref_type:String = "";
	public var ref_micid:String = "";
  private var _path:String = "";
	private var _href:String = "";

	public function VOMenu(rawData:Object, papa:VOMenu = null) {	
    super(rawData);
    this.papa = papa;
    _path = Objects.getValue(rawData, "path_alias") ||Objects.getValue(rawData, "path");
		mlid = rawData.mlid;
		plid = rawData.plid;
		title = rawData.title;
		optionsAttributes = Objects.getValue(rawData, "options.attributes");
		langcode = Objects.getValue(rawData, "options.langcode");
		description = Objects.getValue(rawData, "description");
		attributeID = Objects.getValue(rawData, "options.attributes.id");
		expanded = rawData.expanded == "1" ? true : false;
		external = rawData.external == "1" ? true : false;
		has_children = rawData.has_children == "1" ? true : false;
		hidden = rawData.hidden == "1" ? true : false;
		_href = rawData.href;
		weight = int(rawData.weight);
		depth = int(rawData.depth);
		page_callback = rawData.page_callback;
		ref_nids = Objects.getValue(rawData, "ref_nids");
		ref_types = Objects.getValue(rawData, "ref_types");
		ref_nid = Objects.getValue(rawData, "ref_nid");
		ref_type = Objects.getValue(rawData, "ref_type");
		ref_micid = Objects.getValue(rawData, "ref_micid");
    
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


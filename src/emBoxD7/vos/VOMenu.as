package emBoxD7.vos {
  import emBox.utils.Objects;
  import emBox.vos.VO;

//TODO move to emBoxAS3Lib
public class VOMenu extends VOD7 {
	public var plid:String = ""; //The mlid of the parent.
	public var description:String = "";
	public var titleGreek:String = "";
	public var descriptionGreek:String = "";
	public var expanded:Boolean;
	public var external:Boolean;
	public var has_children:Boolean;
	public var hidden:Boolean;
	public var weight:int;
	public var depth:int;
	public var papa:VOMenu;
	public var children:Array = [];
	public var page_callback:String = "";
	public var options:Object = { };
	public var language:String = "";
	public var ref_nid:String = "";
	public var ref_type:String = "";

	public function VOMenu(rawData:Object, papa:VOMenu = null) {	
    super(rawData);
    this.papa = papa;
		plid = Objects.getValue(rawData, "plid");
		options = Objects.getValue(rawData, "options");
		language = Objects.getValue(rawData, "language");
		description = Objects.getValue(rawData, "description");
		expanded = rawData.expanded == "1" ? true : false;
		external = rawData.external == "1" ? true : false;
		has_children = rawData.has_children == "1" ? true : false;
		hidden = rawData.hidden == "1" ? true : false;
		weight = int(rawData.weight);
		depth = int(rawData.depth);
		page_callback = Objects.getValue(rawData, "page_callback");
		ref_nid = Objects.getValue(rawData, "ref_nid");
		ref_type = Objects.getValue(rawData, "ref_type");
  }
}
}


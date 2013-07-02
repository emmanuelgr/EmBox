package emBoxD7.vos {
import emBox.dataObjects.*;
import emBox.utils.Objects;
import emBox.vos.VO;
import emBoxD7.dataObjects.StringI18n;

public class VODrupalTaxonomy extends VOD7{
	
	public var nodes:Array = [];
	public var childrenTids:Array = [];
	public var vocabulary:Object = {};
	
	public function VODrupalTaxonomy(rawData:Object){
		super(rawData);
    
    nodes = Objects.getValue(rawData, "nodes");
    childrenTids = Objects.getValue(rawData, "children_tids");
    vocabulary = Objects.getValue(rawData, "vocabulary");
	}
  
}
}


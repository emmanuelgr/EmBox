package emBoxD6.vos {
import emBox.dataObjects.*;
import emBox.utils.Objects;
import emBox.vos.VO;

public class VODrupalTaxonomy extends VODrupalNode{
	
	public var ref_nids:Array = [];
	public var ref_types:Array = [];
	
	public function VODrupalTaxonomy(rawData:Object){
		super(rawData);
    
    ref_nids = Objects.getValue(rawData, "ref_nids");
    ref_types = Objects.getValue(rawData, "ref_types");
	}
  
}
}


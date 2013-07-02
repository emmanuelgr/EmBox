package emBoxD6.vos {
import emBox.dataObjects.*;

public class VODrupalNodeTaxonomyTerm {
	public var name:String = "";
	public var tid:String = "";
	public var vid:String = "";
	public var description:String = "";
	public var weight:int;
	
	public function VODrupalNodeTaxonomyTerm(name:String = "", tid:String = "", vid:String = "", description:String = "", weight:int = 0){
		this.name = name;
		this.tid = tid;
		this.vid = vid;
		this.description = description;
		this.weight = weight;
	}

}
}


package gr.emmanuel.emBoxAS3.vos {

public class VO extends Object{
	
	static public var totalVOs:int = 0;

  /// set the id of this instance
	public const id:int = VO.totalVOs;
	public var type:String = String(this).split("[").join("").split("]").join("").split(" ").join("").split("object").join("")
	
	public function VO(rawData:Object) {
    /// update counter for vos
    VO.totalVOs++;
	}
  
}
}
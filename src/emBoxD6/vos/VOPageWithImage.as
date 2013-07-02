package emBoxD6.vos {

public class VOPageWithImage extends VODrupalNode {
	
	public var image:String = "";
	public var width:int;
	public var height:int;
	
	public function VOPageWithImage(rawData:Object){
		super(rawData);
		image = rawData.field_image[0].filename;
	}
  
}
}
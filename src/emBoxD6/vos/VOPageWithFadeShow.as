package emBoxD6.vos {

public class VOPageWithFadeShow extends VODrupalNode {
	
	public var images:Array = [];
	public var widths:Array = [];
	public var heights:Array = [];
	
	public function VOPageWithFadeShow(rawData:Object){
		super(rawData);
	
    for(var i:int = 0; i < rawData.field_images.length; i++){
			if(rawData.field_images[i] != null){
				images.push(rawData.field_images[i].filename);
			}
		}
	}
}
}


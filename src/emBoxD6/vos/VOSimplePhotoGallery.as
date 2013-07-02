package emBoxD6.vos {

public class VOSimplePhotoGallery extends VODrupalNode {
	
	public var titles:Array = [];
	public var descriptions:Array = [];
	public var images:Array = [];
	public var widths:Array = [];
	public var heights:Array = [];
	
	public function VOSimplePhotoGallery(rawData:Object){
		super(rawData);
		
		for(var i:int = 0; i < rawData.field_photo.length; i++){
			rawData.images.push(rawData.field_photo[i].filename);
			rawData.titles.push(rawData.field_photo[i].data.title);
			rawData.descriptions.push(rawData.field_photo[i].data.description);
		}
	}

}
}


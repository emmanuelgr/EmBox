package emBoxD6.vos {
  import emBox.utils.Objects;

public class VOPageWithVideo extends VODrupalNode {
	
	public var video:String = "";
	public var width:int;
	public var height:int;
  public var vimeoClipId:int = 0;
	
	public function VOPageWithVideo(rawData:Object){
		super(rawData);
    video = rawData.field_video[0].filepath;
		width = parseInt(rawData.field_video[0].data.width);
		height = parseInt(rawData.field_video[0].data.height);
    
		var s:String = Objects.getValue(rawData, "field_embedded_video.0.value") as String;
		if(s) vimeoClipId = s.split("?")[0];
	}
  
}
}
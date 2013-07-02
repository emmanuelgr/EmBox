package emBoxD6.vos {

public class VOMusic extends VODrupalNode {
	
	public var description:Array = [];
	public var music:Array = [];
	public var titles:Array = [];
	public var durations:Array = [];
	
	public function VOMusic(rawData:Object){
		super(rawData);
		for(var i:int = 0; i < rawData.field_music.length; i++){
			music.push(rawData.field_music[i].filename);
				//fieldDescription.push( rawData.field_music[i].data.description);
		}
	}

}
}


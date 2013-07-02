package emBoxD7.vos {

public class VOMusic extends VODrupalNode {
	private var fieName:String;
	
	public var description:Array = [];
	public var music:Array = [];
	public var titles:Array = [];
	public var durations:Array = [];
	
	public function VOMusic(rawData:Object) {
		super(rawData);
		for(var i:int = 0; i < rawData.field_music.length; i++) {
			fieName = rawData.field_music[i].filename;
			music.push(fieName);
				//fieldDescription.push( rawData.field_music[i].data.description);
		}
		for(var j:int = 0; j < rawData.field_music.und.length; j++) {
			fieName = rawData.field_music["und"][j]["filename"];
			music.push(fieName);
		}
	}
}
}

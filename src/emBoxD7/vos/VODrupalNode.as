package emBoxD7.vos {
import emBox.dataObjects.*;
import emBox.utils.Objects;
import emBox.vos.VO;
import emBoxD7.dataObjects.StringI18n;
import emBoxD7.EmBoxD7;

public class VODrupalNode extends VOD7{
	
	public var nid:String = "";
	public var body:String = "";
	public var teaser:String = "";
	public var titleField:StringI18n = new StringI18n();
	public var bodyI18n:StringI18n = new StringI18n();
	public var teaserI18n:StringI18n = new StringI18n();
	public var language:String = "";
	public var taxonomyTerms:Vector.<String> = new Vector.<String>();
  
	public function VODrupalNode(rawData:Object){
    super(rawData);
		nid = Objects.getValue(rawData, "nid");
		language = Objects.getValue(rawData, "language") || "";
		body = Objects.getValue(rawData, "body.und.0.value")||"";
		body = body.split("\r").join("");
    teaser = Objects.getValue(rawData, "teaser.und.0.value")||"";
		teaser = teaser.split("\r").join("");
		//teaser = Objects.getValue(rawData, "teaser")||"";
		//teaser = teaser.split("\r").join("");
		titleField = StringI18n.populateStringI18nField( rawData, "title_field");
		bodyI18n = StringI18n.populateStringI18nField( rawData, "body");
		teaserI18n = StringI18n.populateStringI18nField( rawData, "body", "summary");
	}
  
}
}


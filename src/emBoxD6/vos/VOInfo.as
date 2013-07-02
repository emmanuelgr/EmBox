package emBoxD6.vos {
  import emBox.utils.Objects;
  import emBoxD6.EmBoxD6;

public class VOInfo extends VODrupalNode {
	
	public var image:String = "";
	public var street:String = "";
	public var streetNumber:String = "";
	public var town:String = "";
	public var city:String = "";
	public var postcode:String = "";
	public var phone:Array = [];
	public var fax:Array = [];
	public var email:Array = [];
	public var tweeterTitle:String = "";
	public var tweeterURL:String = "";
	public var facebookTitle:String = "";
	public var facebookURL:String = "";
	public var site_frontpage:String = "";
	public var site_name:String = "";
	public var site_mail:String = "";
	public var site_slogan:String = "";
	public var site_mission:String = "";
	public var site_footer:String = "";
	
	public function VOInfo(rawData:Object){
		super(rawData);
    
		image = Objects.getValue(rawData, "field_image.0.filename");
		street = Objects.getValue(rawData, "field_street.0.value");
		streetNumber = Objects.getValue(rawData, "field_street_number.0.value");
		town = Objects.getValue(rawData, "field_town.0.value");
		city = Objects.getValue(rawData, "field_city.0.value");
		postcode = Objects.getValue(rawData, "field_postcode.0.value");
		var anArray:Array = Objects.getValue(rawData, "field_phone");
		if(anArray){
			for(var i:int = 0; i < anArray.length; i++){
				phone.push(anArray[i]["value"]);
			}
		}
		anArray = Objects.getValue(rawData, "field_fax");
		if(anArray){
			for(var k:int = 0; k < anArray.length; k++){
				fax.push(anArray[k]["value"]);
			}
		}
		anArray = Objects.getValue(rawData, "field_email");
		if(anArray){
			for(var l:int = 0; l < anArray.length; l++){
				email.push(anArray[l]["email"]);
			}
		} else {
			email.push(site_mail);
		}
		tweeterTitle = Objects.getValue(rawData, "field_tweeter.0.title");
		tweeterURL = Objects.getValue(rawData, "field_tweeter.0.url");
		facebookTitle = Objects.getValue(rawData, "field_facebook.0.title");
		facebookURL = Objects.getValue(rawData, "field_facebook.0.url");
		site_frontpage = Objects.getValue(rawData, "field_site_info.site_frontpage");
		site_name = Objects.getValue(rawData, "field_site_info.site_name");
		site_mail = Objects.getValue(rawData, "field_site_info.site_mail");
		site_slogan = Objects.getValue(rawData, "field_site_info.site_slogan");
		site_mission = Objects.getValue(rawData, "field_site_info.site_mission");
		site_footer = Objects.getValue(rawData, "field_site_info.site_footer");
		
		EmBoxD6.sitesFront = site_frontpage;
		EmBoxD6.sitesName = site_name;
		EmBoxD6.sitesEmail = site_mail;
		EmBoxD6.sitesSlogan = site_slogan;
		EmBoxD6.sitesMission = site_mission;
		EmBoxD6.sitesFooterMessage = site_footer;
	}

}
}
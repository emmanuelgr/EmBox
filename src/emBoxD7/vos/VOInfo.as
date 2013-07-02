package emBoxD7.vos {
  import emBox.utils.Objects;
  import emBoxD7.dataObjects.ArrayI18n;
  import emBoxD7.dataObjects.StringI18n;
  import emBoxD7.EmBoxD7;

public class VOInfo extends VODrupalNode {
  private var anArray:Array;
	
	public var image:String = "";
	public var googleMapTitle:String = "";
	public var googleMapURL:String = "";
	public var street:StringI18n ;
	public var streetNumber:StringI18n ;
	public var town:StringI18n ;
	public var city:StringI18n ;
	public var postcode:StringI18n ;
	public var businessHours:ArrayI18n ;
	public var phone:ArrayI18n ;
	public var fax:ArrayI18n ;
	public var email:ArrayI18n ;
	public var tweeterTitle:StringI18n ;
	public var tweeterURL:StringI18n ;
	public var facebookTitle:StringI18n ;
	public var facebookURL:StringI18n ;
	
	public function VOInfo(rawData:Object){
		super(rawData);
    
		image = Objects.getValue(rawData, "field_image.und.0.filename") || Objects.getValue(rawData, "field_image.0.filename");
		googleMapTitle = Objects.getValue(rawData, "field_google_maps.und.0.title");
		googleMapURL = Objects.getValue(rawData, "field_google_maps.und.0.url");
		street = StringI18n.populateStringI18nField(rawData, "field_street");
		streetNumber = StringI18n.populateStringI18nField(rawData, "field_street_number");
		town = StringI18n.populateStringI18nField(rawData, "field_town");
		city = StringI18n.populateStringI18nField(rawData, "field_city");
		postcode = StringI18n.populateStringI18nField(rawData, "field_postcode");
		businessHours = ArrayI18n.populateArrayI18nField(rawData, "field_business_hours");
		phone = ArrayI18n.populateArrayI18nField(rawData, "field_phone");
		fax = ArrayI18n.populateArrayI18nField(rawData, "field_fax");
		email = ArrayI18n.populateArrayI18nField(rawData, "field_email", "email");
		tweeterTitle = Objects.getValue(rawData, "field_tweeter.0.title");
		tweeterURL = Objects.getValue(rawData, "field_tweeter.0.url");
		facebookTitle = Objects.getValue(rawData, "field_facebook.0.title");
		facebookURL = Objects.getValue(rawData, "field_facebook.0.url");
	}

}
}
package emBoxD7.commands {

public class CConnect extends ACServiceCall{
	public static var DOMAIN:String ;
	public static var API_KEY:String;
 	public static var GATEWAY_URL:String; //
	
  /**
   *
   * @param	domain www.domainName.gr no http:// will add
   * @param	apiKey if you have keys enabled
   * @param	gateway_url
   *  D6 sites / all / modules / amfphp / amfphp / core / amf / app /Gateway.php line 354  set to false function disableStandalonePlayer($value = false)
   */
	public function CConnect(domain:String, apiKey:String, gateway_url:String="/services/amfphp"){
    DOMAIN = domain;
    API_KEY = apiKey;
    GATEWAY_URL = "http://" + domain + gateway_url;
		super("system.connect");
  }
	
	override protected function onResult(o:Object = null):void {
		session_id = String(o.sessid);
		trace("Session ID " + o.sessid);
		super.onResult(o);
	}
}
}


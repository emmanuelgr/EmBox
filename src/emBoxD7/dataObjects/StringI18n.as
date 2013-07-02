package emBoxD7.dataObjects {
	import emBox.dataObjects.StringEnGr;
  import emBox.utils.Objects;

/**
 * ...
 * @author Emmanuel
 */
public class StringI18n extends StringEnGr{
	
	public function StringI18n() {	}
  
	/**
   * 
   * @param	rawData
   * @param	attribute
   * @param	valueName the attribute name usaually value but on custom filed module as email will be email
   * @return
   */
  public static function populateStringI18nField(rawData:Object,attribute:String , valueName:String="value" ):StringI18n {
    var stringI18n:StringI18n = new StringI18n();
    if (rawData.hasOwnProperty(attribute)) {
      
      if (rawData[attribute].hasOwnProperty("und")) {
        stringI18n.en = stringI18n.el = Objects.getValue(rawData, attribute + ".und.0." + valueName);
      }else{
        stringI18n.en = Objects.getValue(rawData, attribute + ".en.0." + valueName);
        stringI18n.el = Objects.getValue(rawData, attribute + ".el.0." + valueName);
        if (!stringI18n.el) stringI18n.el = stringI18n.en;
        if (!stringI18n.en) stringI18n.en = stringI18n.el;
        if (!stringI18n.en && !stringI18n.el) stringI18n.en = stringI18n.el="No Value";
      }
    }else {
      stringI18n.en = stringI18n.el = attribute + " doesnt exist!";
    }
    stringI18n.en = stringI18n.en.split("\r").join("");
    stringI18n.el = stringI18n.el.split("\r").join("");
    return stringI18n;
  }
  
}
}
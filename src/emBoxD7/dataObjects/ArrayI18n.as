package emBoxD7.dataObjects {
  import emBox.utils.Objects;

/**
 * ...
 * @author Emmanuel
 */
public class ArrayI18n {
	public var en:Array;
	public var el:Array;
	
	public function ArrayI18n() {
    en = [];
    el = [];
	}
  
  /**
   * 
   * @param	rawData
   * @param	attribute
   * @param	valueName the attribute name usaually value but on custom filed module as email will be email
   * @return
   */
  public static function populateArrayI18nField(rawData:Object,attribute:String, valueName:String="value" ):ArrayI18n {
    var arrayI18n:ArrayI18n = new ArrayI18n();
    var anArray:Array = [];
    
    
    
    if (rawData.hasOwnProperty(attribute)) {
      
      if (rawData[attribute].hasOwnProperty("und")) {
        anArray = Objects.getValue(rawData, attribute + ".und");
        if(anArray){
          for(var j:int = 0; j < anArray.length; j++){
            arrayI18n.en.push(anArray[j][valueName]);
            arrayI18n.el.push(anArray[j][valueName]);
          }
        }
      }else {
        anArray = Objects.getValue(rawData, attribute + ".en");
        if(anArray){
          for(var k:int = 0; k < anArray.length; k++){
            arrayI18n.en.push(anArray[k][valueName]);
          }
        }
        anArray = Objects.getValue(rawData, attribute + ".el");
        if(anArray){
          for(var l:int = 0; l < anArray.length; l++){
            arrayI18n.el.push(anArray[l][valueName]);
          }
        }
      }
      if (!arrayI18n.el) arrayI18n.el = arrayI18n.en;
      if (!arrayI18n.en) arrayI18n.en = arrayI18n.el;
      if (!arrayI18n.en && !arrayI18n.el) arrayI18n.en = arrayI18n.el=[];
    }else {
      arrayI18n.en = arrayI18n.el = [attribute + " doesnt exist!"];
    }
    return arrayI18n;
  }
}
}
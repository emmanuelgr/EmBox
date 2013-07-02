package emBoxD7.commands{
import emBoxD7.commands.ACServiceCall;

public class CGetTaxonomyD7 extends ACServiceCall{

  public function CGetTaxonomyD7(
  tids:Array,
  fields:Array = null,
  operators:String = ""
  ){
    super("taxonomy_term.selectNodes",
    tids
    );
  }
  
}
}



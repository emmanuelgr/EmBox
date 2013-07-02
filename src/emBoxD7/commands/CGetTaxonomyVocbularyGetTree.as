package emBoxD7.commands{
import emBoxD6.commands.ACServiceCall;

public class CGetTaxonomyVocbularyGetTree extends ACServiceCall {

  public function CGetTaxonomyVocbularyGetTree(
  vocabulary:Array
  ){
    super("taxonomy_vocabulary.getTree",1
    //vocabulary
    );
  }
  
}
}



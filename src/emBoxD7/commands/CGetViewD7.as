package emBoxD7.commands{
import emBoxD6.commands.ACServiceCall;

public class CGetViewD7 extends ACServiceCall {
  
  public function CGetViewD7(
  viewName:String,
  display_id:String = "default",
  args:Array = null
  ){
    super("views.retrieve",
    viewName    
    //display_id,
    //args
    );
  }

}
}


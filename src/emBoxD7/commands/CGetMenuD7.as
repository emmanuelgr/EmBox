package emBoxD7.commands{
import emBoxD7.commands.ACServiceCall;

public class CGetMenuD7 extends ACServiceCall{

  public function CGetMenuD7(){
    super("menu.retrieve",
    "main-menu"
    //[
    //"title",
    //"options",
    //"href",
    //"path_alias",
    //"weight",
    //"depth",
    //"has_children",
    //"children",
    //"hidden"
    //]
    );
  }
}
}


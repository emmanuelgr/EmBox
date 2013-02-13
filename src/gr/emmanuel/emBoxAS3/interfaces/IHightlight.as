package gr.emmanuel.emBoxAS3.interfaces {
import gr.emmanuel.emBoxAS3.commands.ACommand;

public interface IHightlight {
  function set hightlight( value:ACommand):void;
  function get hightlight():ACommand;
}
}
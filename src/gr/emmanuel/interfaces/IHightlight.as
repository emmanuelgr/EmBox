package gr.emmanuel.interfaces {
import gr.emmanuel.commands.ACommand;

public interface IHightlight {
  function set hightlight( value:ACommand):void;
  function get hightlight():ACommand;
}
}
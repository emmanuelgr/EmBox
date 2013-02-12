package gr.emmanuel.interfaces {
import gr.emmanuel.commands.ACommand;

public interface IAppears {
  function set appears( value:ACommand):void;
  function get appears():ACommand;
}
}
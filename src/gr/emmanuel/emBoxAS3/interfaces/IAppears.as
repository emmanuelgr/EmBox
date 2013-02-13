package gr.emmanuel.emBoxAS3.interfaces {
import gr.emmanuel.emBoxAS3.commands.ACommand;

public interface IAppears {
  function set appears( value:ACommand):void;
  function get appears():ACommand;
}
}
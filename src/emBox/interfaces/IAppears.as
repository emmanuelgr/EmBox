package emBox.interfaces {
  import emBox.commands.ACommand;

public interface IAppears {
  function set appears( value:ACommand):void;
  function get appears():ACommand;
}
}
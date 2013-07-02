package emBox.interfaces {
  import emBox.commands.ACommand;

public interface IHover {
  function set hover( value:ACommand):void;
  function get hover():ACommand;
}
}
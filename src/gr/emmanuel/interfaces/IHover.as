package gr.emmanuel.interfaces {
  import gr.emmanuel.commands.ACommand;

public interface IHover {
  function set hover( value:ACommand):void;
  function get hover():ACommand;
}
}
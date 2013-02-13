package gr.emmanuel.emBoxAS3.interfaces {
  import gr.emmanuel.emBoxAS3.commands.ACommand;

public interface IHover {
  function set hover( value:ACommand):void;
  function get hover():ACommand;
}
}
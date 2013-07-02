package emBox.interfaces {
  import emBox.commands.ACommand;

public interface IHightlight {
  function set hightlight( value:ACommand):void;
  function get hightlight():ACommand;
}
}
package gr.emmanuel.emBoxAS3.commands.interfaces {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Emmanuel
	 */
	public interface ICommand {
		
		function executeIn( e:Event = null ):void;
		function executeOut( e:Event = null ):void;
	}
	
}
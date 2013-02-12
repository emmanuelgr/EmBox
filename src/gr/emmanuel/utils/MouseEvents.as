package gr.emmanuel.utils {
import flash.events.*;

/**
 * ...
 * @author emmanuel
 */
public class MouseEvents {
	
	/**
	 * Traces
	 */
	public static function traceProperties(e:MouseEvent):void {
		trace(  );
		trace( "traceProperties" );
		trace( "e.type : " + e.type );
		trace( "Click e.eventPhase : " + e.eventPhase);
		trace( "Click e.currentTarget : " + e.currentTarget);
		trace( "Click e.target : " + e.target);
		trace(  );
		
	}
	
}
}


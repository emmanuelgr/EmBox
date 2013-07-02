package emBox.commands.air {
import emBox.commands.ACommand;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.filesystem.File;

/**
 * ...
 * @author Emmanuel
 */
public class CMoveToAsynch extends ACommand {
	private var file:File;
	private var destination:File;
	private var overwrite:Boolean;
	
	public function CMoveToAsynch(file:File,destination:File, overwrite:Boolean=false) {
		super();
		this.overwrite = overwrite;
		this.file = file;
		this.destination = destination;
	}
	
	override protected function doIn():void {
		super.doIn();
		file.addEventListener(Event.COMPLETE, fileMoveCompleteHandler);
		file.addEventListener(IOErrorEvent.IO_ERROR, fileMoveIOErrorEventHandler);
		file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
		file.moveToAsync(destination,overwrite);
	}
	
	private function onSecError(e:SecurityErrorEvent):void {
		trace( "e : " + e );
		trace( "e.type : " + e.type );
		trace( "e.errorID : " + e.errorID );
		
	}
	
	private function fileMoveCompleteHandler(event:Event):void {
		executeInComplete();
	}
	private function fileMoveIOErrorEventHandler(event:IOErrorEvent):void {
		trace("CMoveToAsynch I/O Error.");
	}
	
	override protected function doOut():void {
		super.doOut();
		file.removeEventListener(Event.COMPLETE, fileMoveCompleteHandler);
		file.removeEventListener(IOErrorEvent.IO_ERROR, fileMoveIOErrorEventHandler);
		file.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecError);
		executeOutComplete();
	}
	
}
}
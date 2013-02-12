package gr.emmanuel.commands.air {
import gr.emmanuel.commands.ACommand;
import gr.emmanuel.commands.CommandEvent;
import gr.emmanuel.utils.Objects;
import flash.data.SQLConnection;
import flash.data.SQLMode;
import flash.events.SQLErrorEvent;
import flash.events.SQLEvent;
import flash.filesystem.File;

/**
 * ...
 * @author Emmanuel
 */
public class CConnect extends ACommand {
	private var file:File;
	private var sqlMode:String;
	private var sqlConnection:SQLConnection;
	
	public function CConnect(file:File, sqlConnection:SQLConnection, sqlMode:String = null) {
		this.file = file;
		this.sqlConnection = sqlConnection;
		this.sqlMode = sqlMode || SQLMode.CREATE;
		super();
	}
	
	override protected function doIn():void {
		super.doIn();
		sqlConnection.addEventListener(SQLEvent.OPEN, onOpen);
		sqlConnection.addEventListener(SQLErrorEvent.ERROR, onError);
		sqlConnection.openAsync(file, sqlMode);
	}
	protected function onOpen(e:SQLEvent):void {
		sqlConnection.removeEventListener(SQLEvent.OPEN, onOpen);
		sqlConnection.removeEventListener(SQLErrorEvent.ERROR, onError);
		traceDuration("Connected ! ")
		executeInComplete(sqlConnection);
	}
	
	protected function onError(e:SQLErrorEvent = null):void {
		dispatchEvent(new CommandEvent(CommandEvent.EXECUTE_ERROR, e));
		trace("Connection  ERROR ");
		Objects.traceDynamicAtributes(e);
	}
	
	override protected function doOut():void {
		super.doOut();
		sqlConnection.addEventListener(SQLEvent.CLOSE, onClose);
		sqlConnection.addEventListener(SQLErrorEvent.ERROR, onError);
		sqlConnection.close();
	}
	
	private function onClose(e:SQLEvent):void {
		sqlConnection.removeEventListener(SQLEvent.CLOSE, onClose);
		sqlConnection.removeEventListener(SQLErrorEvent.ERROR, onError);
		executeOutComplete();
	}
}

}


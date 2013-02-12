package gr.emmanuel.commands.air {
import gr.emmanuel.commands.ACommand;
import gr.emmanuel.commands.CommandEvent;
import flash.data.SQLConnection;
import flash.data.SQLResult;
import flash.data.SQLStatement;
import flash.events.SQLErrorEvent;
import flash.events.SQLEvent;

/**
 * ...
 * @author Emmanuel
 */
public class CSQLStatement extends ACommand {
	private var sqlConnection:SQLConnection;
	private var statement:String;
	private var sqlStatement:SQLStatement;
	private var functionAcceptingaSQLResult:Function;
	private var vo:Class;
	
	public function CSQLStatement(sqlConnection:SQLConnection, statement:String, functionAcceptingaSQLResult:Function=null,vo:Class=null) {
		this.vo = vo;
		this.sqlConnection = sqlConnection;
		this.statement = statement;
		this.functionAcceptingaSQLResult = functionAcceptingaSQLResult;
		super();
		sqlStatement = new SQLStatement();
		sqlStatement.text = statement;
		sqlStatement.sqlConnection = sqlConnection;
		if(vo) sqlStatement.itemClass = vo;
	}
	
	override protected function doIn():void {
		super.doIn();
		sqlStatement.addEventListener(SQLEvent.RESULT, onResultSQL);
		sqlStatement.addEventListener(SQLErrorEvent.ERROR, onErrorSQL);
		sqlStatement.execute();
	}
	
	protected function onResultSQL(e:SQLEvent):void {
		if ((e.target as SQLStatement) != sqlStatement) return;
		var sqlResult:SQLResult = (e.target as SQLStatement).getResult();
		sqlStatement.removeEventListener(SQLEvent.RESULT, onResultSQL);
		sqlStatement.removeEventListener(SQLErrorEvent.ERROR, onErrorSQL);
		if (functionAcceptingaSQLResult is Function) functionAcceptingaSQLResult.apply(null,[sqlResult]);
		executeInComplete(sqlResult);
	}
	private function onErrorSQL(e:SQLErrorEvent):void {
		dispatchEvent(new CommandEvent(CommandEvent.EXECUTE_ERROR, e));
		//Objects.traceDynamicAtributes(e);
		trace("SQLErrorEvent : " + e);
	}
	
	override protected function doOut():void {
		super.doOut();
		sqlStatement.removeEventListener(SQLEvent.RESULT, onResultSQL);
		sqlStatement.removeEventListener(SQLErrorEvent.ERROR, onErrorSQL);
		executeOutComplete();
	}
	
}

}


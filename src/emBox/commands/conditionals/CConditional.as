package emBox.commands.conditionals {
import emBox.commands.ACommand;
import emBox.utils.Objects;

/**
 * ...
 * @author Emmanuel
 */
public class CConditional extends ACConditional {
	private var object:Object;
	private var attribute:String;
	private var value:*;
	private var omparisonOperator:String;
	
	public function CConditional(object:Object, attribute:String, value:*, commandA:ACommand = null, commandB:ACommand = null, omparisonOperator:String = "==") {
		this.object = object;
		this.attribute = attribute;
		this.value = value;
		this.omparisonOperator = omparisonOperator;
		super(commandA, commandB);
	}
	
	override protected function doIn():void {
		super.doIn();
		switch (omparisonOperator) {
			case "==": 
				if (Objects.getValue(object, attribute) == value) {
					doInTrue();
				} else {
					doInFalse();
				}
				break;
			case "!=": 
				if (Objects.getValue(object, attribute) != value) {
					doInTrue();
				} else {
					doInFalse();
				}
				break;
		}
	}
	
	override protected function doOut():void {
		super.doOut();
		switch (omparisonOperator) {
			case "==": 
				if (Objects.getValue(object, attribute) == value) {
					doOutTrue();
				} else {
					doOutFalse();
				}
				break;
			case "!=": 
				if (Objects.getValue(object, attribute) != value) {
					doOutTrue();
				} else {
					doOutFalse();
				}
				break;
		}
	
	}

}
}

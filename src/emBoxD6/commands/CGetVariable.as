package emBoxD6.commands{

	public class CGetVariable extends ACServiceCall{

		public function CGetVariable(variableName:String){
			super("system.getVariable",
			variableName
			);
		}
	}
}


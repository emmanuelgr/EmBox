package emBoxD6.commands{

	public class CGetView extends ACServiceCall{

		public function CGetView(
		viewName:String,
		display_id:String = "default",
		args:Array = null
		){
			super("views.get",
			viewName,
			display_id,
			args
			);
		}

	}
}


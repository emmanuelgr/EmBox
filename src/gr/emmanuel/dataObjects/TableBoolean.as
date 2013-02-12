package gr.emmanuel.dataObjects {
	/**
	 * ...
	 * @author emmanuel
	 */
	public class TableBoolean{
		private var rows:int;
		private var columns:int;
		public  var table:Vector.<Boolean>;
		private var shift:int;
		
		public function TableBoolean(columns:int, rows:int){
			this.rows = rows;
			this.columns = columns;
			shift = 7;
			var cells:Number =  columns*rows;
			table  = new Vector.<Boolean>(cells  << shift , true);
			for (var x:int = 0; x < columns; x++){
				for (var y:int = 0; y < rows; y++){
					table[(x << shift) | y] = false;
				}
			}
		}
		public function getcell(x:int, y:int):Boolean	{
			var valid:Boolean = false;
			if ( table[(x << shift) | y]){
				valid = true;
			}
			return valid;
		}		
		public function setCell(x:int, y:int, state:Boolean):void	{
			table[(x << shift) | y] = state;
		}		
	}

}
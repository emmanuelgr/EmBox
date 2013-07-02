package emBox.utils.xml{
	public class PathInXML {
		private var node:XML;
		private var myArray:Array= new Array();
		private var path:String = "";
		
		public function PathInXML(node:XML){
			this.node = node;
			// init myArray with the input  node index
			myArray.push( String(node.childIndex( )) );
			
			traverse(node);
			
			function traverse(node:XML):void{
				if (node.parent() != null && node.parent().childIndex()>=0 ){
					myArray.unshift( String( node.parent( ).childIndex( )) );
					traverse(node.parent());
				}
			}	
			
			for (var i:int = 0; i < myArray.length; i++) 	{
				path = path + String(myArray[i])     ;
			}
			//trace("the path is :"+path);
		}
		
		public function get itsPath():String {
			return path; 
		}		
	}
	
}
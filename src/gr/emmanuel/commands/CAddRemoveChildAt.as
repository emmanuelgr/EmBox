package gr.emmanuel.commands {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Emmanuel
	 */
	public class CAddRemoveChildAt extends ACommand {
		private var aParent:DisplayObjectContainer;
		private var theChild:DisplayObject;
		private var index:int;

		public function CAddRemoveChildAt( aParent:DisplayObjectContainer, theChild:DisplayObject, index:int){
			this.index = index;
			this.aParent = aParent;
			this.theChild = theChild;
		}

		override protected function doIn():void  {
			super.doIn();

			if ( aParent && theChild )  aParent.addChildAt( theChild, index );

			executeInComplete();
		}
		override protected function doOut():void {
			super.doOut();

			if ( aParent && theChild  &&  theChild.parent  && theChild.parent == aParent )  aParent.removeChild( theChild );

			executeOutComplete();
		}

	}

}

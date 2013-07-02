package emBox.sprites.icons{
	import emBox.core.NineGrid;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
  import flash.geom.Point;
	/**
	 * ...
	 * @author emmanuel
	 */
	public class Cube10 extends Sprite	{
		private var size:Number;
		private var left:DisplayObject;
		private var right:DisplayObject;
		private var front:DisplayObject;
		private var back:DisplayObject;
		private var top:DisplayObject;
		private var bottom:DisplayObject;
		private var nineGrid:String;

		public function Cube10(
		left:DisplayObject,
		right:DisplayObject,
		front:DisplayObject,
		back:DisplayObject,
		top:DisplayObject,
		bottom:DisplayObject,
		nineGrid:String = NineGrid.MiddleMiddle
		){
			super();
			this.left = left;
			this.right = right;
			this.front = front;
			this.back = back;
			this.top = top;
			this.bottom = bottom;
			this.nineGrid = nineGrid;
			init();
		}
		private function init():void {

			top.z += top.height;
			top.rotationX = -90;

			bottom.rotationX = 90;
			bottom.y += front.height;

			left.z += left.width;
			left.rotationY = 90;

      right.x += front.width;
			right.rotationY = -90;

			back.z += left.width;

			addChild(back);
			addChild(bottom);
			addChild(right);
			addChild(top);
			addChild(left);
			addChild(front);

			var nineGridPnt:Point =NineGrid.regPoint(nineGrid);
			for (var i:int = 0; i < numChildren; i++){
			var aChild:DisplayObject = getChildAt(i);
			aChild.x -= Math.round (  front.width   * nineGridPnt.x );
			aChild.y -= Math.round (  front.height  * nineGridPnt.y );
			}
		}
	}
}


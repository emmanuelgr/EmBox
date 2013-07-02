package emBox.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix3D;

	/**
	 * ...
	 * @author emmanuel
	 */
	public class DisplayObjectContainers {

		public function DisplayObjectContainers(	) { }

		public static function sortClipsB(childInContainer:DisplayObjectContainer) : void		{
			var container:DisplayObjectContainer = childInContainer;
			//bubble sorts children along world z-axis
			for( var i:int = childInContainer.numChildren- 1; i > 0; i-- ){
				var hasSwapped:Boolean = false;
				for( var j:int = 0; j < i; j++ ){
					//z value at that index for each child
					var aDOA:DisplayObject = childInContainer.getChildAt(i);
					var aDOB:DisplayObject = childInContainer.getChildAt(i - 1);
					var z1:Number = aDOA.transform.getRelativeMatrix3D(container).position.z;
					var z2:Number = aDOB.transform.getRelativeMatrix3D(container).position.z;
					if( z2> z1 ){
						//swap
						childInContainer.swapChildrenAt( j, j + 1 );
						hasSwapped = true;
					}
				}
				//if there was no swap, we donâ€™t need to iterate again
				if( !hasSwapped ) return;
			}
		}
		public static function sortClips(childInContainer:DisplayObjectContainer) : void		{
			var container:DisplayObjectContainer = childInContainer;
			//if (childInContainer.numChildren < 2) return;
			//trace("childInContainer : " + childInContainer);
			if (!childInContainer) return;
			var aMatrix:Matrix3D;
			var aDO:DisplayObject;
			var sortArray:Array = [];
			for (var i:int = 0; i < childInContainer.numChildren; i++){
				aDO = childInContainer.getChildAt(i) as DisplayObject;
				//if (aDO is DisplayObjectContainer || aDO is Trident10 || aDO is Cube10Constant) sortClips(aDO as DisplayObjectContainer);
				sortClips(aDO as DisplayObjectContainer);
				aMatrix= aDO.transform.getRelativeMatrix3D(container)
				if (!aMatrix) continue;
				sortArray.push(new VO(aDO, aMatrix.position.z));
			}
			sortArray.sortOn("screenZ",    Array.DESCENDING);
			for (var k:int = 0; k < sortArray.length; k++){
				aDO = sortArray[k].object;
				childInContainer.setChildIndex(aDO, k);
			}
			sortArray = null;
		}
	}

}

import flash.display.DisplayObject;
class VO	{
	public var object : DisplayObject;
	public var screenZ:Number;
	public function VO(object : DisplayObject, screenZ:Number){
		this.object = object;
		this.screenZ = screenZ;
	}
}


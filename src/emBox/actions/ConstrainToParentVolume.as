package emBox.actions {
import emBox.sprites.EmBoxSprite;
import emBox.sprites.EmBoxSpriteLiquid;
import emBox.core.NineGrid;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;
import flash.ui.Keyboard;

/**
* Calculates potition to the size of parent if UI and EmBoxSpriteLiquid size is limited
* @author Emmanuel
*/
public class ConstrainToParentVolume extends ConstrainToStage {
	
	public function ConstrainToParentVolume(constrained:DisplayObject, constrainedUV:String, constrainerUV:String, compensate:Boolean = false, offsetX:Number = 0, offsetY:Number = 0){
		super(constrained, constrainedUV, constrainerUV, compensate, offsetX, offsetY)
	}
	
	override protected function customize():void {
		initConstrainerSize.x = constrained.parent.width;
		initConstrainerSize.y = constrained.parent.height;
	}
	
	override protected function customiseCompentation():void {
		initConstainedPosition.x = constrained.x;
		initConstainedPosition.y = constrained.y;
		compensatationOffset.x = initConstrainerSize.x * constrainerUV.x - initConstainedPosition.x;
		compensatationOffset.y = initConstrainerSize.y * constrainerUV.y - initConstainedPosition.y;
	}
	
	override public function update(event:Event = null):void {
    if ( !constrained.parent ) return;
		constrainerSize.x = constrained.parent.width;
		constrainerSize.y = constrained.parent.height;
		
		constrained.x = constrainerUV.x * constrainerSize.x;
		constrained.y = constrainerUV.y * constrainerSize.y;
		if (constrained.parent is EmBoxSprite){
			constrained.x += (constrained.parent as EmBoxSprite).nineGridOffsetX;
			constrained.y += (constrained.parent as EmBoxSprite).nineGridOffsetY;
		}
		
    constrained.x -= constrainedUV.x * constrained.width;
		constrained.y -= constrainedUV.y * constrained.height;
		if (constrained is EmBoxSprite ){
			//trace(constrained is EmBoxSprite, constrained is EmBoxSpriteLiquid)
			constrained.x -= (constrained as EmBoxSprite).nineGridOffsetX;
			constrained.y -= (constrained as EmBoxSprite).nineGridOffsetY;
		}
		
		constrained.x += _offsetX;
		constrained.y += _offsetY;
		
		constrained.x = Math.round(constrained.x);
		constrained.y = Math.round(constrained.y);
	}

}
}
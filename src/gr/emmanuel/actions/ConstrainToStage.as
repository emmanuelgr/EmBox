package gr.emmanuel.actions {
import gr.emmanuel.vos.VO;
import flash.display.Stage;
import gr.emmanuel.core.NineGrid;
import flash.display.DisplayObject;
import flash.events.Event;
import flash.geom.Point;

/**
* ...
* @author Emmanuel
*/

public class ConstrainToStage extends OnOffStage {
	protected var constrained:DisplayObject;
	protected var constrainedUV:Point;
	protected var constrainerUV:Point;
	protected var compensate:Boolean;
	
	protected var compensatationOffset:Point;
	protected var initConstrainerSize:Point;
	protected var initConstainedPosition:Point;
	protected var topLeftBBoxCorner:Point;
	protected var _offsetX:Number;
	protected var _offsetY:Number;
	protected var constrainerSize:Point;
	
  private var aPoint:Point;

	public function ConstrainToStage(constrained:DisplayObject, constrainedUV:String, constrainerUV:String, compensate:Boolean = false, offsetX:Number = 0, offsetY:Number = 0){
		this.constrained = constrained;
		this.constrainedUV = NineGrid.regPoint(constrainedUV);
		this.constrainerUV = NineGrid.regPoint(constrainerUV);
		this.compensate = compensate;
		_offsetX = offsetX;
		_offsetY = offsetY;
    init();
		super(constrained, onStage, null, offStage);
	}
  private function init():void {
    compensatationOffset= new Point();
    initConstrainerSize= new Point();
    initConstainedPosition= new Point();
    topLeftBBoxCorner = new Point();
    aPoint = new Point();
    constrainerSize = new Point();
  }
	
	protected function customize():void {
		initConstrainerSize.x = constrained.stage.stageWidth;
		initConstrainerSize.y = constrained.stage.stageHeight;
	}
	
  protected function customiseCompentation():void {
    initConstainedPosition = constrained.parent.localToGlobal(new Point(constrained.x, constrained.y));
    compensatationOffset.x = initConstrainerSize.x * constrainerUV.x - initConstainedPosition.x;
    compensatationOffset.y = initConstrainerSize.y * constrainerUV.y - initConstainedPosition.y;
  }

	private function onStage(e:Event = null):void {
    if ( !constrained.stage ) return;
		customize();
		if (compensate) customiseCompentation();
		update();
		//constrained.stage.addEventListener(Event.FULLSCREEN, update);
		constrained.stage.addEventListener(Event.RESIZE, update);
		constrained.addEventListener(Event.CHANGE, update);
	}
	
	private function offStage(e:Event = null):void {
		//constrained.stage.removeEventListener(Event.FULLSCREEN, update);
		constrained.stage.removeEventListener(Event.RESIZE, update);
		constrained.removeEventListener(Event.CHANGE, update);
	}
	
	public function update(event:Event = null):void {
		if (!constrained.stage)  return;
		constrainerSize.x = constrained.stage.stageWidth;
		constrainerSize.y = constrained.stage.stageHeight;

		aPoint.x = constrainerUV.x * constrainerSize.x;
		aPoint.y = constrainerUV.y * constrainerSize.y;
		constrained.x = constrained.parent.globalToLocal(aPoint).x;
		constrained.y = constrained.parent.globalToLocal(aPoint).y;
		
		constrained.x -= constrainedUV.x * constrained.width;
		constrained.y -= constrainedUV.y * constrained.height;
		
		constrained.x += _offsetX;
		constrained.y += _offsetY;
		
		constrained.x = Math.round(constrained.x);
		constrained.y = Math.round(constrained.y);
		
		//trace();
		//topLeftBBoxCorner = constrained.getBounds( constrained ).topLeft ;
		//trace("update : " + constrained.name);
		//trace("initConstainedSize : " + initConstainedSize);
		//trace("constrained.width : " + constrained.width + "constrained.height : " + constrained.height);
		//trace("constrained.getBounds( constrained ) : " + constrained.getBounds( constrained ));
		//trace();
	}
	
	public function get offsetX():Number{ 	return _offsetX;}
	public function set offsetX(value:Number):void {
		_offsetX = value;
		if(constrained.stage)update();
	}
	
	public function get offsetY():Number{ 		return _offsetY;}
	public function set offsetY(value:Number):void {
		_offsetY = value;
		if(constrained.stage)update();
	}

}
}

package emBox.locations {
import emBox.actions.AddedRemovedFromContainer;
import emBox.sprites.EmBoxSprite;
import emBox.sprites.EmBoxSpriteLiquid;
import emBox.core.NineGrid;
import emBox.shapes.Frame;
import emBox.shapes.Margin;
import emBox.utils.DisplayObjects;
import emBox.utils.Maths;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.geom.Point;

/**
 * ...
 * @author emmanuel
 */
public class LocationHoriz implements ILocation {
	protected var _container:DisplayObjectContainer;
	public var padding_X:Number;
	public var margin_X:Number = 0;
	private var aNumber:Number = 0;
	protected var cell_W:Number = 0;
	protected var cell_H:Number = 0;
	protected var cell_Final_W:Number = 0;
	protected var container_available_W:Number = 0;
	protected var offset_inPixels:int = 0;
	protected var available_margin_X:Number = 0;
	protected var padding_Added_X:Number = 0;
	protected var margin_Added_X:Number = 0;
	private var cell_offset:uint = 0;
	protected var list:Array = [];
	protected var rawOfset:Array = [];
	protected var aDisplayObject:DisplayObject;
	private var _offset:Number = 0;
	private var _pushOutside:Boolean;
	protected var stretch:Boolean;
	protected var element_max_width:Number = 0;
	
	public function LocationHoriz(container:DisplayObjectContainer, list:Array, padding_X:Number = 5, padding_Y:Number = 5, margin_X:Number = 10, margin_Y:Number = 10, stretch:Boolean = false, pushOutside:Boolean = false){
		this.list = list;
		_container = container;
		this.padding_X = padding_X;
		this.margin_X = margin_X;
		this.stretch = stretch;
		_pushOutside = pushOutside;
		super();
	}
	
	public function setList(list:Array):void {
		this.list = list;
		refresh();
	}
	
	public function refresh(event:Event = null):void {
		refreshData();
		refreshAllNodes();
	}
	
	public function refreshData():void {
		rawOfset = [];
    var acc:Number = 0;
		for (var i:int = 0; i < list.length; i++) {
      rawOfset.push(acc)
			element_max_width = Math.max(element_max_width, list[i].width);
      acc += list[i].width + padding_X;
		}
		cell_W = element_max_width + padding_X;
		
		container_available_W = _container.width - margin_X * 2;
		
		/// remaining pixels
		available_margin_X = Maths.clamp(container_available_W - acc, 0, Number.MAX_VALUE);
		
		/// Stretch calculations for the value of pixels to add to padding;
		padding_Added_X = 0;
		margin_Added_X = 0;
		
		if(available_margin_X > 0){
			if(stretch){
				padding_Added_X = available_margin_X / acc;
			} else {
				margin_Added_X = available_margin_X / 2;
			}
		}
		
		/// calc the final size of an element
		cell_Final_W = element_max_width;
		cell_Final_W += padding_X;
		cell_Final_W += padding_Added_X;
		
		/// calc offset
		offset_inPixels = 0
		
	}
	
	public function refreshAllNodes(event:Event = null):void {
		for(var i:int = 0; i < list.length; i++){
			refreshNode(i);
		}
	}
	
	public function refreshNode(index:int):void {
		aDisplayObject = list[index];
		/// set the raw position
		aDisplayObject.x = rawOfset[index];
		aDisplayObject.y = container.height / 2 - aDisplayObject.height / 2;
		/// add the padding
		aDisplayObject.x += padding_X / 2;
		/// add the calculated padding
		aDisplayObject.x += padding_Added_X;
		/// add the calculated margin
		aDisplayObject.x += margin_Added_X;
		/// add the offset  of the index
		aDisplayObject.x += offset_inPixels;
    
    
		aDisplayObject.y += offset_inPixels;
    
    
		
		/// Push outside
		if(_pushOutside){
			
			if(aDisplayObject.x >= container_available_W)
				aDisplayObject.x += margin_X;
			if(aDisplayObject.x < 0)
				aDisplayObject.x -= margin_X;
		}
		
		/// add the default margin
		aDisplayObject.x += margin_X;
		/// add the containers registration Point Offset*/
		if(_container is EmBoxSprite){
			aDisplayObject.x += (_container as EmBoxSprite).nineGridOffsetX;
			aDisplayObject.y += (_container as EmBoxSprite).nineGridOffsetY;
		}
		/// add the thumbs registration Point Offset*/
		if(aDisplayObject is EmBoxSprite){
			aDisplayObject.x -= (list[index] as EmBoxSprite).nineGridOffsetX;
			aDisplayObject.y -= (list[index] as EmBoxSprite).nineGridOffsetY;
		}
		
		aDisplayObject.x = Math.round(aDisplayObject.x);
		aDisplayObject.y = Math.round(aDisplayObject.y);
	}
	
	public function scroll(value:Number):void {
		var n:Number;
		n = (container_available_W - cell_Final_W) / 2;
		_offset = Maths.clamp(_offset, n, 1 - n);
		refresh();
	}
	
	public function get offset():Number {
		return _offset;
	}
	
	public function set offset(value:Number):void {
		if(0 > value || value > 1)
			value = Maths.wrap(value, 1);
		_offset = value;
		refresh();
	}
	
	public function get offsetTo():int {
		return _offset * list.length;
	}
	
	public function set offsetTo(value:int):void {
		value = Maths.clamp(value, 0, list.length - 1);
		_offset = value / list.length;
		trace(_offset);
		refresh();
	}
	
	public function get container():DisplayObjectContainer {
		return _container;
	}
	
	public function set container(value:DisplayObjectContainer):void {
		_container = value;
	}
	
	public function get pushOutside():Boolean {
		return _pushOutside;
	}
	
	public function set pushOutside(value:Boolean):void {
		_pushOutside = value;
		refresh();
	}

}
}
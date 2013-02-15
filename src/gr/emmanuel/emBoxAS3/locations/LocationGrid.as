package gr.emmanuel.emBoxAS3.locations {
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;
import gr.emmanuel.emBoxAS3.core.NineGrid;
import gr.emmanuel.emBoxAS3.locations.events.LocationEvent;
import gr.emmanuel.emBoxAS3.locations.interfaces.ILocation;
import gr.emmanuel.emBoxAS3.locations.core.LocationNode;
import gr.emmanuel.emBoxAS3.shapes.Frame;
import gr.emmanuel.emBoxAS3.shapes.Margin;
import gr.emmanuel.emBoxAS3.sprites.EmBoxSprite;

[Event(name="change",type="gr.emmanuel.emBoxAS3.locations.events")]

/**
 * ...
 * @author emmanuel
 */
public class LocationGrid extends EventDispatcher implements ILocation {
	private var _bound:Rectangle;
	private var _layHoriz:Boolean = true;
	private var _paddingHor:Number = 5;
	private var _paddingVer:Number = 5;
	private var _marginHor:Number = 10;
	private var _marginVer:Number = 10;
	private var _tileW:Number = 0;
	private var _tileH:Number = 0;
	private var _pushOutside:Boolean = false;
	private var _stretch:Boolean = false;
	private var _offset:Number = 0;
	private var _totalElements:int = 0;
	private var _offsetPixels:Number = 0;
	
	private var cell_offset:uint = 0;
	private var aNumber:Number = 0;
	private var stage:Stage;
	private var list:Vector.<LocationNode>;
	private var aLocationNode:LocationNode;
	
	protected var bbox_Columns:uint = 0;
	protected var bbox_Rows:uint = 0;
	protected var bbox_W:Number = 0;
	protected var bbox_H:Number = 0;
	protected var cell_Min_W:Number = 0;
	protected var cell_Min_H:Number = 0;
	protected var cell_Final_W:Number = 0;
	protected var cell_Final_H:Number = 0;
	protected var bounds_Columns:uint = 0;
	protected var bounds_Rows:uint = 0;
	protected var bounds_Available_W:Number = 0;
	protected var bounds_Available_H:Number = 0;
	protected var bounds_Quotient_W:Number = 0;
	protected var bounds_Quotient_H:Number = 0;
	protected var bounds_Dim_Center:int = 0;
	protected var dimension_Offset:int = 0;
	protected var available_pixels_W:Number = 0;
	protected var available_pixels_H:Number = 0;
	protected var padding_Final_Hor:Number = 0;
	protected var padding_Final_Ver:Number = 0;
	protected var margin_Final_Hor:Number = 0;
	protected var margin_Final_Ver:Number = 0;
	
	private var debug_margin:Margin;
  private var debug_bbox:Frame;
  private var debugRemainingWidth:EmBoxSprite;
  private var debugRemainingHeigth:EmBoxSprite;
  private var debugFlag:Boolean= false;
	
	public function LocationGrid(bound:Rectangle, tileW:Number, tileH:Number, totalElements:int, stage:Stage) {
		this.stage = stage;
		_bound = bound;
		_tileW = tileW;
		_tileH = tileH;
		this.totalElements = totalElements;
		this.stage = stage;
		super();
		invalidate();
  }
  public function debug(stage:Stage):void {
    if (!debugFlag) {
			debugFlag = true
      debug_margin = new Margin( _bound.width, _bound.height, _marginHor, _marginVer, 0x45074B, 0.5, NineGrid.TopLeft);
      //debug_bbox = new EmBoxSprite( 0, 0, null, 0xFFFFFF, 0.1 );
      debug_bbox = new Frame( 0, 0, 1, 0x3AAEE7, 0.5, NineGrid.TopLeft );
      debugRemainingWidth = new EmBoxSprite( 0, 10, null, 0xff0000, 0.5 );
      debugRemainingHeigth = new EmBoxSprite( 10, 0, null, 0x00ff00, 0.5 );
			stage.addChild(debug_margin);
			stage.addChild(debug_bbox)
			stage.addChild(debugRemainingWidth)
			stage.addChild(debugRemainingHeigth)
    }
  }
	
	protected function col(index:int):Number {
		if (layHoriz) {
			aNumber = index % bounds_Columns;
		} else {
			aNumber = Math.floor(index / bounds_Rows);
		}
		return aNumber;
	}
	
	protected function row(index:int):Number {
		if (layHoriz) {
			aNumber = Math.floor(index / bounds_Columns);
		} else {
			aNumber = index % bounds_Rows;
		}
		return aNumber;
	}
	
	public function invalidate(event:Event = null):void {
		stage.addEventListener(Event.ENTER_FRAME, validateNow);
	}
	
	private function validateNow(e:Event):void {
		stage.removeEventListener(Event.ENTER_FRAME, validateNow);
		refreshLayout();
		refreshAllNodes();
		dispatchEvent(new LocationEvent(LocationEvent.CHANGE, list));
	}
	
	private function refreshLayout():void {
		
		cell_Min_W = _tileW + _paddingHor;
		cell_Min_H = _tileH + _paddingVer;
		
		bounds_Available_W = _bound.width - _marginHor * 2;
		bounds_Available_H = _bound.height - _marginVer * 2;
		
		bounds_Quotient_W = bounds_Available_W / cell_Min_W;
		bounds_Quotient_H = bounds_Available_H / cell_Min_H;
		
		// the dimention of the _bound
		bounds_Columns = Math.floor(bounds_Quotient_W);
		bounds_Rows = Math.floor(bounds_Quotient_H);
		
		// the bounding box of the cells
		if (layHoriz) {
			bbox_W = Math.min(bounds_Columns, totalElements) * cell_Min_W;
			bbox_H = Math.ceil(totalElements / bounds_Columns) * cell_Min_H;
		} else {
			bbox_H = Math.min(bounds_Rows, totalElements) * cell_Min_H;
			bbox_W = Math.ceil(totalElements / bounds_Rows) * cell_Min_W;
		}
		
		// the dimention of the bbox
		bbox_Columns = Math.floor(bbox_W / cell_Min_W);
		bbox_Rows = Math.floor(bbox_H / cell_Min_H);
		
		// remaining pixels
		available_pixels_W = bounds_Available_W - bbox_W;
		available_pixels_H = bounds_Available_H - bbox_H;
		
		// Stretch calculations for the value of pixels to add to padding;
		padding_Final_Hor = 0;
		padding_Final_Ver = 0;
		margin_Final_Ver = 0;
		margin_Final_Hor = 0;
		
		
		if (stretch) {
			 //calc padding to be added so tiles are occupying the available area
			if (layHoriz && available_pixels_W > 0) {
				
				padding_Final_Hor = available_pixels_W / (bbox_Columns + 1);
				
			}else if (!layHoriz && available_pixels_H > 0) {
				
				padding_Final_Ver = available_pixels_H / (bbox_Rows + 1);
			}
			
		}else {
			 //calc margin to be added so tiles are centered
			if (layHoriz && available_pixels_W > 0) {
				
				margin_Final_Hor = available_pixels_W / 2;
				
			}else if (!layHoriz && available_pixels_H > 0) {
				
				margin_Final_Ver = available_pixels_H / 2;
				
			}
		}
		
		
			//padding_Final_Hor = (bounds_Quotient_W - bounds_Columns) * cell_Min_W / (bounds_Columns + 1);
			//padding_Final_Ver = (bounds_Quotient_H - bounds_Rows) * cell_Min_H / (bounds_Rows + 1);
		
		// calc the final size of an element to be mult by the col and row index
		cell_Final_W = cell_Min_W;
		cell_Final_H = cell_Min_H;
		cell_Final_W += padding_Final_Hor;
		cell_Final_H += padding_Final_Ver;
		
		// calc offset
		if (!layHoriz) {
			dimension_Offset = col(totalElements * _offset);
			bounds_Dim_Center = Math.floor(bounds_Columns / 2);
			_offsetPixels = -clamp(dimension_Offset - bounds_Dim_Center, 0, bbox_Columns - bounds_Columns) * cell_Final_W;
		} else {
			dimension_Offset = row(totalElements * _offset);
			bounds_Dim_Center = Math.floor(bounds_Rows / 2);
			_offsetPixels = -clamp(dimension_Offset - bounds_Dim_Center, 0, bbox_Rows - bounds_Rows) * cell_Final_H;
		}
		
    if(debugFlag) {
			debug_margin.x = _bound.x;
			debug_margin.y = _bound.y;
			debug_margin.width = _bound.width;
			debug_margin.height = _bound.height;
      debug_bbox.x = debug_margin.x + marginHor;
      debug_bbox.y = debug_margin.y + marginVer;
      debug_bbox.width = bbox_W;
      debug_bbox.height = bbox_H;
      debugRemainingWidth.x = debug_bbox.x + debug_bbox.width ;
      debugRemainingWidth.y = debug_bbox.y ;
      debugRemainingWidth.width = available_pixels_W;
      debugRemainingHeigth.x = debug_bbox.x ;
      debugRemainingHeigth.y = debug_bbox.y + debug_bbox.height ;
      debugRemainingHeigth.height = available_pixels_H;
    }
	}
	
	private function refreshAllNodes(event:Event = null):void {
		for (var i:int = 0; i < totalElements; i++) {
			refreshNode(i);
		}
	}
	
	private function refreshNode(index:int):void {
		aLocationNode = list[index];
		
		// set the raw position
		aLocationNode.x = cell_Final_W * col(index);
		aLocationNode.y = cell_Final_H * row(index);
		// add the default margin
		aLocationNode.x += _marginHor;
		aLocationNode.y += _marginVer;
		// add the padding
		aLocationNode.x += _paddingHor / 2;
		aLocationNode.y += _paddingVer / 2;
		// add the calculated margin
		aLocationNode.x += margin_Final_Hor;
		aLocationNode.y += margin_Final_Ver;
		// add the offset  of the index
		aLocationNode.x += !layHoriz ?  (available_pixels_W  ) * _offset: 0;
		aLocationNode.y +=  layHoriz ?  (available_pixels_H  ) * _offset: 0;
		
		// set the snapped coords to the the non snapped ones
		aLocationNode.xSnapped = aLocationNode.x;
		aLocationNode.ySnapped = aLocationNode.y;
		// add the calculated padding
		aLocationNode.xSnapped += padding_Final_Hor;
		aLocationNode.ySnapped += padding_Final_Ver;
		// add the offset  of the index
		aLocationNode.xSnapped += !layHoriz ? _offsetPixels : 0;
		aLocationNode.ySnapped +=  layHoriz ? _offsetPixels : 0;
		
		// Push outside
		if (_pushOutside) {
			if (layHoriz) {
				//if (aLocationNode.ySnapped >= bounds_Available_H) {
				if (aLocationNode.ySnapped >= bbox_H) {
					aLocationNode.ySnapped += _marginVer;
				}
				if (aLocationNode.ySnapped < 0) {
					aLocationNode.ySnapped -= _marginVer;
				}
			}
		} else {
			//if (aLocationNode.xSnapped >= bounds_Available_W) {
			if (aLocationNode.xSnapped >= bbox_W) {
				aLocationNode.xSnapped += _marginHor;
				if (aLocationNode.xSnapped < 0) {
					aLocationNode.xSnapped -= _marginHor;
				}
			}
		}
		
		
		
		aLocationNode.xSnapped = Math.round(aLocationNode.xSnapped);
		aLocationNode.ySnapped = Math.round(aLocationNode.ySnapped);
		
		// visabilty
		if (layHoriz) {
			if ( aLocationNode.y < 0 || aLocationNode.y >= bounds_Available_H) {
				aLocationNode.visible = false;
			}else{
				aLocationNode.visible = true;
			}
		} else {
			if (aLocationNode.x < 0 || aLocationNode.x >= bounds_Available_W) {
				aLocationNode.visible = false;
			}else{
				aLocationNode.visible = true;
			}
		}
	}
	
	
	public function get offsetPixels():Number {
		return _offsetPixels;
	}
	
	public function set offsetPixels(value:Number):void {
		if (layHoriz) {
			offset += value / bound.height;
		}else {
			offset += value / bound.width;
		}
		invalidate();
	}
	
	public function scroll(value:Number):void {
		var r:Number;
		var n:Number;
		if (!layHoriz) {
			r = value / bbox_Columns;
			n = (bounds_Available_W - cell_Final_W) / 2 / bbox_W;
		} else {
			r = value / bbox_Rows;
			n = (bounds_Available_H - cell_Final_H) / 2 / bbox_H;
		}
		_offset = clamp(_offset + r, n, 1 - n);
		invalidate();
	}
	
	public function get offset():Number {
		return _offset;
	}
	
	public function set offset(value:Number):void {
		value = clamp(value, 0, 1);
		//if (0 > value || value > 1)
			//value = wrap(value, 1);
		_offset = value;
		invalidate();
	}
	
	public function get offsetIndex():int {
		return _offset * (totalElements-1);
	}
	
	public function set offsetIndex(value:int):void {
		value = clamp(value, 0, (totalElements-1) );
		_offset = value / (totalElements-1);
		invalidate();
	}
	
	public function get bound():Rectangle {
		return _bound;
	}
	
	public function set bound(value:Rectangle):void {
		_bound = value;
		invalidate();
	}
	
	public function get pushOutside():Boolean {
		return _pushOutside;
	}
	
	public function set pushOutside(value:Boolean):void {
		_pushOutside = value;
		invalidate();
	}
	
	public function get paddingHor():Number {
		return _paddingHor;
	}
	
	public function set paddingHor(value:Number):void {
		_paddingHor = value;
		invalidate();
	}
	
	public function get paddingVer():Number {
		return _paddingVer;
	}
	
	public function set paddingVer(value:Number):void {
		_paddingVer = value;
		invalidate();
	}
	
	public function get marginHor():Number {
		return _marginHor;
	}
	
	public function set marginHor(value:Number):void {
		_marginHor = value;
		invalidate();
	}
	
	public function get marginVer():Number {
		return _marginVer;
	}
	
	public function set marginVer(value:Number):void {
		_marginVer = value;
		invalidate();
	}
	
	public function get layHoriz():Boolean {
		return _layHoriz;
	}
	
	public function set layHoriz(value:Boolean):void {
		_layHoriz = value;
		invalidate();
	}
	
	public function get stretch():Boolean {
		return _stretch;
	}
	
	public function set stretch(value:Boolean):void {
		_stretch = value;
		invalidate();
	}
	
	public function get totalElements():int {
		return _totalElements;
	}
	
	public function set totalElements(value:int):void {
		_totalElements = value;
		list = new Vector.<LocationNode>(value);
		for (var i:int = 0; i < value; i++) {
			list[i] = new LocationNode();
		}
		invalidate();
	}
	
	public function get tileW():Number {
		return _tileW;
	}
	
	public function set tileW(value:Number):void {
		_tileW = value;
		invalidate();
	}
	
	public function get tileH():Number {
		return _tileH;
	}
	
	public function set tileH(value:Number):void {
		_tileH = value;
		invalidate();
	}
	
	//////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////
	private function clamp(valueToClamp:Number, minValue:Number, maxValue:Number):Number {
		if (isNaN(valueToClamp) || isNaN(minValue) || isNaN(maxValue))
			return 0;
		var result:Number = Math.max(minValue, Math.min(maxValue, valueToClamp));
		return result;
	}
	
	private static function wrap(valueToWrap:Number, maxValue:Number):Number {
		function w(v:Number):Number {
			return (v + maxValue) % maxValue;
		}
		var result:Number = w(valueToWrap);
		if (!result)
			result = 0; //so it wont return NaN
		if (result < 0)
			result = w(result); //so it wont return negative
		//trace("valueToWrap: " + valueToWrap + " result: " + result)
		return result;
	}
	
}
}
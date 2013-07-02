package emBox.locations {
import emBox.actions.AddedRemovedFromContainer;
import emBox.sprites.EmBoxSprite;
import emBox.sprites.EmBoxSpriteLiquid;
import emBox.core.NineGrid;
import emBox.shapes.Frame;
import emBox.shapes.Margin;
import emBox.utils.DisplayObjects;
import emBox.utils.Maths;
import emBox.utils.Objects;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.geom.Point;
/**
 * ...
 * @author emmanuel
 */
public class LocationGrid implements ILocation {
  protected var _container:DisplayObjectContainer;
  protected var layHoriz:Boolean;
  public var padding_X:Number;
  public var padding_Y:Number;
  public var margin_X:Number = 0;
  public var margin_Y:Number = 0;
  private var aNumber:Number = 0;
  protected var container_dim_X:uint=0;
  protected var container_dim_Y:uint = 0;
  protected var bbox_dim_X:uint=0;
  protected var bbox_dim_Y:uint=0;
  protected var bbox_W:Number = 0;
  protected var bbox_H:Number = 0;
  protected var cell_W:Number = 0;
  protected var cell_H:Number = 0;
  protected var cell_Final_W:Number = 0;
  protected var cell_Final_H:Number = 0;
  protected var container_available_W:Number = 0;
  protected var container_available_H:Number = 0;
  protected var quotient_W:Number = 0;
  protected var quotient_H:Number = 0;
  protected var dimension_Offset:int = 0;
  protected var container_Dim_Center:int = 0;
  protected var offset_inPixels:int = 0;
  protected var available_margin_X:Number = 0;
  protected var available_margin_Y:Number = 0;
  protected var padding_Added_X:Number = 0;
  protected var padding_Added_Y:Number = 0;
  protected var margin_Added_X:Number = 0;
  protected var margin_Added_Y:Number = 0;
  private var cell_offset:uint = 0;
  private var debug_margin:Margin;
  private var debug_bbox:Frame;
  private var debugRemainingWidth:EmBoxSprite;
  private var debugRemainingHeigth:EmBoxSprite;
  private var debug:Boolean= false;
	protected var list:Array = [];
	protected var aDisplayObject:DisplayObject;
	private var _offset:Number=0;
  private var _pushOutside:Boolean;
  protected var stretch:Boolean;
	protected var element_max_width:Number= 0;
	protected var element_max_heigth:Number= 0;

  public function LocationGrid(
  container:DisplayObjectContainer,
  list:Array,
  layHoriz:Boolean =true,
  padding_X:Number = 5,
  padding_Y:Number = 5,
  margin_X:Number = 10,
  margin_Y:Number = 10,
  stretch:Boolean = false,
  pushOutside:Boolean = false
  ){
    this.list = list;
		_container = container;
    this.layHoriz = layHoriz;
    this.padding_X = padding_X;
    this.padding_Y = padding_Y;
    this.margin_X = margin_X;
    this.margin_Y = margin_Y;
    this.stretch = stretch;
    _pushOutside = pushOutside;
    super();
    init();
  }
  private function init():void {
    if (debug) {
      debug_margin = new Margin( _container.width, _container.height, margin_X, margin_Y, 0x000000, 0.3, _container is EmBoxSprite?EmBoxSprite(_container).nineGrid:null);
      //debug_bbox = new EmBoxSprite( 0, 0, null, 0xFFFFFF, 0.1 );
      debug_bbox = new Frame( 0, 0, 1, 0xFFFFFF, 0.3, NineGrid.TopLeft );
      debugRemainingWidth = new EmBoxSprite( 0, 10, null, 0xff0000, 0.5 );
      debugRemainingHeigth = new EmBoxSprite( 10, 0, null, 0x00ff00, 0.5 );
      if(!_container.stage)
        _container.addEventListener(Event.ADDED_TO_STAGE, addtostage)
      else {
        addtostage()
      }
      function addtostage(e:Event=null):void {
        _container.stage.addChild(debug_margin);
        _container.stage.addChild(debug_bbox)
        _container.stage.addChild(debugRemainingWidth)
        _container.stage.addChild(debugRemainingHeigth)
      }
    }
  }

  public function setList(list:Array):void {
    this.list = list;
    refresh();
  }
  protected function col( index:int ):Number {
    if (layHoriz){
      aNumber =  index % container_dim_X ;
    }else {
      aNumber =   Math.floor( index  / container_dim_Y );
    }
    return aNumber;
  }
  protected function row( index:int ):Number {
    if (layHoriz){
      aNumber =   Math.floor( index  / container_dim_X );
    }else {
     aNumber =   index % container_dim_Y ;
    }
    return aNumber;
  }

	public function refresh(event:Event = null):void {
		refreshData();
		refreshAllNodes();
	}
	
	
  public function refreshData():void {
    
		for (var i:int = 0; i < list.length; i++) {
			element_max_width = Math.max(element_max_width, list[i].width);
			element_max_heigth = Math.max(element_max_heigth, list[i].height);
		}
    cell_W = element_max_width  + padding_X;
    cell_H = element_max_heigth + padding_Y;

    container_available_W = _container.width  - margin_X * 2;
    container_available_H = _container.height - margin_Y * 2;

    quotient_W = container_available_W / cell_W;
    quotient_H = container_available_H / cell_H;

    /// the dimention of the _container
    container_dim_X = Math.floor( quotient_W );
    container_dim_Y = Math.floor( quotient_H );

    /// the bounding box of the cells on stage
    if (layHoriz) {
      bbox_W = Math.min( container_dim_X, list.length) * cell_W;
      bbox_H = Math.ceil(list.length / container_dim_X ) * cell_H;
    }else {
      bbox_H = Math.min( container_dim_Y, list.length) * cell_H;
      bbox_W = Math.ceil(list.length / container_dim_Y ) * cell_W;
    }

    /// the dimention of the bbox
    bbox_dim_X = Math.floor( bbox_W / cell_W );
    bbox_dim_Y = Math.floor( bbox_H / cell_H );

    /// remaining pixels
    available_margin_X = Maths.clamp( container_available_W - bbox_W, 0, Number.MAX_VALUE);
    available_margin_Y = Maths.clamp( container_available_H - bbox_H, 0, Number.MAX_VALUE);

    /// Stretch calculations for the value of pixels to add to padding;
    padding_Added_X = 0;
    padding_Added_Y = 0;
    margin_Added_Y  = 0;
    margin_Added_X  = 0;

    if(available_margin_X > 0) {
      if(stretch) {
        padding_Added_X = available_margin_X / (bbox_dim_X + 1);
      }else {
        margin_Added_X = available_margin_X / 2;
      }
    }else {
      padding_Added_X = ( quotient_W - container_dim_X ) * cell_W / (container_dim_X + 1) ;
    }

    if(available_margin_Y > 0) {
      if(stretch) {
        padding_Added_Y = available_margin_Y / (bbox_dim_Y + 1);
      }else {
        margin_Added_Y = available_margin_Y / 2;
      }
    }else {
      padding_Added_Y = ( quotient_H - container_dim_Y ) * cell_H / (container_dim_Y + 1) ;
    }

    /// calc the final size of an element to be mult by the col and row index
    cell_Final_W =  element_max_width;
    cell_Final_H =  element_max_heigth;
    cell_Final_W += padding_X;
    cell_Final_H += padding_Y;
    cell_Final_W += padding_Added_X;
    cell_Final_H += padding_Added_Y;

    /// calc offset
    if( !layHoriz ) {
      dimension_Offset = col( list.length * _offset);
      container_Dim_Center = Math.floor( container_dim_X / 2);
      offset_inPixels = - Maths.clamp( dimension_Offset - container_Dim_Center, 0, bbox_dim_X - container_dim_X) * cell_Final_W;
    }else {
      dimension_Offset = row( list.length * _offset);
      container_Dim_Center = Math.floor( container_dim_Y / 2);
      offset_inPixels = - Maths.clamp( dimension_Offset - container_Dim_Center, 0, bbox_dim_Y - container_dim_Y) * cell_Final_H;
    }

    
    if(debug) {
      DisplayObjects.matchPosition(debug_margin, _container);
      DisplayObjects.matchSize(debug_margin, _container);
      debug_bbox.x = debug_margin.x + margin_X + _container is EmBoxSprite?EmBoxSprite(_container).nineGridOffsetX:0;
      debug_bbox.y = debug_margin.y + margin_Y + _container is EmBoxSprite?EmBoxSprite(_container).nineGridOffsetY:0;
      debug_bbox.width = bbox_W;
      debug_bbox.height = bbox_H;
      debugRemainingWidth.x = debug_bbox.x + debug_bbox.width ;
      debugRemainingWidth.y = debug_bbox.y ;
      debugRemainingWidth.width = available_margin_X;
      debugRemainingHeigth.x = debug_bbox.x ;
      debugRemainingHeigth.y = debug_bbox.y + debug_bbox.height ;
      debugRemainingHeigth.height = available_margin_Y;
    }

  }
  
  public function refreshAllNodes(event:Event = null):void {
    for (var i:int = 0; i < list.length; i++) {
      refreshNode(i);
    }
  }

  
  public function refreshNode(index:int):void {
    aDisplayObject = list[index];
    	var vars:Object = { };
      
    /// set the raw position
    vars["x"] = cell_Final_W * col( index ) ;
    vars["y"] = cell_Final_H * row( index );
    /// add the padding
    vars["x"]+= padding_X/2;
    vars["y"]+= padding_Y / 2;
    /// add the calculated padding
    vars["x"]+= padding_Added_X;
    vars["y"]+= padding_Added_Y;
    /// add the calculated margin
    vars["x"]+= margin_Added_X;
    vars["y"]+= margin_Added_Y;
    /// add the offset  of the index
    vars["x"]+= !layHoriz ? offset_inPixels : 0;
    vars["y"]+=  layHoriz ? offset_inPixels : 0;

    /// Push outside
    if (_pushOutside) {
      
      if( !layHoriz ) {
        if( vars["x"]>=  container_available_W ) vars["x"]+= margin_X;
        if( vars["x"]<  0 ) vars["x"]-= margin_X;
      }else {
        if( vars["y"]>=  container_available_H ) vars["y"]+= margin_Y;
        if( vars["y"]<  0 ) vars["y"]-= margin_Y;
      }
    }

    /// add the default margin
    vars["x"]+=  margin_X;
    vars["y"]+=  margin_Y;
    /// add the containers registration Point Offset*/
		if (_container is EmBoxSprite) {
			vars["x"]+= (_container as EmBoxSprite).nineGridOffsetX;
			vars["y"]+= (_container as EmBoxSprite).nineGridOffsetY;
		}
    /// add the thumbs registration Point Offset*/
		if (aDisplayObject is EmBoxSprite) {
			vars["x"]-= (list[index] as EmBoxSprite).nineGridOffsetX;
			vars["y"]-= (list[index] as EmBoxSprite).nineGridOffsetY;
		}
		
		vars["x"]=  Math.round(vars["x"]);
		vars["y"] =  Math.round(vars["y"]);
    applyValuesToNode(index, vars);
  }
  
  protected function applyValuesToNode(index:int,vars:Object):void {
    aDisplayObject = list[index];
    Objects.setProperties( aDisplayObject, vars);
  }
  
  public function scroll(value:Number):void {
    var r:Number;
    var n:Number;
    if ( !layHoriz ) {
      r = value / bbox_dim_X;
      n = (container_available_W -  cell_Final_W) / 2 / bbox_W;
    }else {
      r = value / bbox_dim_Y;
      n = (container_available_H -  cell_Final_H) / 2 / bbox_H;
    }
    _offset = Maths.clamp(  _offset + r , n, 1-n );
    refresh();
  }

  public function get offset():Number {    return _offset;  }
  public function set offset(value:Number):void {
    if ( 0 > value || value > 1 ) value = Maths.wrap( value, 1);
    _offset =    value;
    refresh();
  }

  public function get offsetTo():int { 
    return _offset * list.length;  
  }
  public function set offsetTo(value:int):void {
    value = Maths.clamp(value, 0, list.length-1 );
    _offset = value / list.length;
    trace( "LocationGrid._offset: " + _offset );
    refresh();
  }
	
  public function get container():DisplayObjectContainer {		return _container;	}
	public function set container(value:DisplayObjectContainer):void {
		_container = value;
	}
  
  public function get pushOutside():Boolean {    return _pushOutside;  }
  public function set pushOutside(value:Boolean):void {
    _pushOutside = value;
    refresh();
  }
	

}
}
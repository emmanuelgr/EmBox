package emBox.sprites.widgets {
import emBox.actions.MouseOverOutable;
import emBox.commands.ACommand;
import emBox.commands.vfxs.*;
import emBox.interfaces.IHover;
import emBox.shapes.EmBoxShape;
import emBox.sprites.EmBoxSprite;
import emBox.dataObjects.ACollectionDispatcher;
import emBox.dataObjects.VectorObjectDispatcher;
import emBox.EmBox;

import emBox.interfaces.IStartStop;
import emBox.core.NineGrid;
import emBox.sprites.thumbs.buttons.AButton;
import emBox.core.Slider;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;

/**
 * ...
 * @author emmanuel
 */
public class SliderView extends EmBoxSprite implements IStartStop {
	private var mdl:VectorObjectDispatcher
	private var colorThumb:uint;
	private var colorThumbAccent:uint;
	private var colorTrack:uint;
	private var slider:Slider;
	private var thumbButton:EmBoxSprite;
	private var _hasStarted:Boolean=false;
	private var action:MouseOverOutable;
	
	public function SliderView(mdl:VectorObjectDispatcher, width:Number, height:Number, colorThumb:Object = null, colorThumbAccent:Object = null, colorTrack:Object = null, nineGrid:String = null) {
		this.mdl = mdl;
		this.colorThumb = (colorThumb) ? colorThumb as uint : EmBox.Color_AcL1;
		this.colorThumbAccent = (colorThumbAccent) ? colorThumbAccent as uint : EmBox.Color_Ac;
		this.colorTrack = (colorTrack) ? colorTrack as uint : EmBox.Color_BgL1;
		super(width, height, nineGrid)
		init();
	}
	
	private function init():void {
		var thumbSize:int = Math.max(40, width / mdl.list.length);
		//thumbButton = new AButton(new EmBoxShape(width, thumbSize, null, colorThumb));
		thumbButton = new EmBoxSprite(width, thumbSize, null, colorThumb);
		var hover:VFXTint = new VFXTint(thumbButton, colorThumbAccent);
		action = new MouseOverOutable( thumbButton, hover.executeIn, hover.executeOut)
		var trackSlider:Sprite = new Sprite();
		trackSlider.graphics.beginFill(colorTrack);
		trackSlider.graphics.drawRect(0,0,width,height);
		trackSlider.graphics.endFill();
		trackSlider.filters = [new DropShadowFilter(2, 45, 0, 0.33, 4, 4, 1, 1, true)];
		slider = new Slider(thumbButton, trackSlider);
		addChild(slider);
	}
	
	public function start(e:Event = null):void {
		_hasStarted = true;
		action.start();
		slider.start();
		slider.addEventListener(Event.CHANGE, onSlider);
		mdl.addEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		onModelPointer();
	}
	
	public function stop(e:Event = null):void {
		_hasStarted = false;
		action.stop();
		slider.stop();
		slider.removeEventListener(Event.CHANGE, onSlider);
		mdl.removeEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
	}
	
	private function onSlider(e:Event = null):void {
		mdl.pointer = (Math.floor(mdl.list.length * slider.weightX));
	}
	
	private function onModelPointer(e:Event = null):void {
		slider.weightY = mdl.pointer / mdl.list.length;
	}
	
	public function get hasStarted():Boolean { 		return _hasStarted;	}
	public function set hasStarted(value:Boolean):void {
		_hasStarted = value;
	}

}

}


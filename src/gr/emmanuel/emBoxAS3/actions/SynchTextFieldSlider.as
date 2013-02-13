package gr.emmanuel.emBoxAS3.actions {
import gr.emmanuel.emBoxAS3.core.Slider;
import gr.emmanuel.emBoxAS3.interfaces.IStartStop;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.text.TextField;

/**
 * ...
 * @author ...
 */
public class SynchTextFieldSlider implements IStartStop {
	private var slider:Slider;
	private var textField:TextField;
	private var _hasStarted:Boolean = false;
	private var sliderParent:DisplayObjectContainer;
	private var percent:Number;
	private var visibleLines:int;
	
	public function SynchTextFieldSlider(textField:TextField, slider:Slider, sliderParent:DisplayObjectContainer) {
		this.textField = textField;
		this.slider = slider;
		this.sliderParent = sliderParent;
	}
	
	/* INTERFACE interfaces.IStartStop */
	
	public function start(e:Event = null):void {
		
		_hasStarted = true;
		update();
		slider.weightY = 0;
		slider.addEventListener(Event.CHANGE, dragHandler);
		textField.addEventListener(Event.SCROLL, scrollHandler);
	}
	
	public function stop(e:Event = null):void {
		_hasStarted = false;
		
		slider.removeEventListener(Event.CHANGE, dragHandler);
		textField.removeEventListener(Event.SCROLL, scrollHandler);
	}
	
	public function update(e:Event = null):void {
		visibleLines = textField.numLines - textField.maxScrollV + 1;
		percent = visibleLines / textField.numLines;
		if (percent < 1) {
			if (!slider.parent) {
				sliderParent.addChild(slider);
			}
			slider
		} else {
			if (slider.parent) {
				slider.parent.removeChild(slider);
			}
		}
	}
	
	private function dragHandler(e:Event):void {
		textField.scrollV = slider.weightY * textField.maxScrollV;
	}
	
	private function scrollHandler(event:Event):void {
		slider.removeEventListener(Event.CHANGE, dragHandler);
		slider.weightY = (textField.scrollV - 1) / (textField.maxScrollV - 1);
		//trace("scrollV/; " +(textField.scrollV - 1) + " maxScrollV: " + (textField.maxScrollV - 1));
		slider.addEventListener(Event.CHANGE, dragHandler);
	}
	
	public function get hasStarted():Boolean {
		return _hasStarted;
	}
	
	

}

}
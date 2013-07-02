package emBox.actions {
import emBox.interfaces.IStartStop;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.EventDispatcher;
import emBox.actions.OnOffStage;

/**
* Astract class with initial setup for a layout
* @author Emmanuel
*/
public class AddedRemovedFromContainer extends EventDispatcher implements IStartStop{
	private var functionOnStage:Function;
  private var functionOffStage:Function;
  private var argsOn:Array;
  private var argsOff:Array;
	private var index:int;
	private var _hasStarted:Boolean=false;
	public var displayObjectsRepos:Array;
	public var displayObjectsInContainer:Array;
	public var justAdded:DisplayObject;
	public var justRemoved:DisplayObject;
	public var container:DisplayObjectContainer;
	
	public function AddedRemovedFromContainer(
  container:DisplayObjectContainer,
	functionOnStage:Function = null,
  argsOn:Array = null,
  functionOffStage:Function = null,
  argsOff:Array = null
  ){
		this.container = container;
		this.functionOnStage = functionOnStage;
    this.argsOn = argsOn;
    this.functionOffStage = functionOffStage;
    this.argsOff = argsOff;
		super();
		init();
	}
	private function init():void {
		displayObjectsRepos = [];
		displayObjectsInContainer = [];
	}
	public function start(event:Event = null):void {
		_hasStarted = true;
		container.addEventListener(Event.ADDED, onAdded);
		container.addEventListener(Event.REMOVED, onRemoved);
	}
	
	public function stop(event:Event = null):void {
			_hasStarted = false;
		container.removeEventListener(Event.ADDED, onAdded);
		container.removeEventListener(Event.REMOVED, onRemoved);		
	}
	
	private function onAdded(event:Event):void {
		//trace("Target: " + event.target.name);
		//trace("Curren: " + event.currentTarget.name);
		//trace("TargetPapa: " + (event.target as DisplayObject).parent.name);
		if (event.currentTarget != (event.target as DisplayObject).parent)	return;
    index = displayObjectsRepos.indexOf(event.target);
		//trace("index: " + index);
    if(index==-1) return;
    justAdded = event.target as DisplayObject;
		//trace("justAdded>>>>>>>>>>>: " + + event.target);
		displayObjectsInContainer.push(justAdded);
    if (functionOnStage == null ) {
			dispatchEvent(event);
			return;
		}
		functionOnStage.apply(null, argsOn);
	}
	
	private function onRemoved(event:Event):void {
    //trace("Target: " + event.target.name);
		//trace("Curren: " + event.currentTarget.name);
		//trace("TargetPapa: " + (event.target as DisplayObject).parent.name);
    index = displayObjectsRepos.indexOf(event.target);
		//trace("index: " + index);
    if(index==-1) return;
		justRemoved = event.target as DisplayObject;
    //trace("justRemoved<<<<<<<<<<<: " + event.target);
		displayObjectsInContainer.splice(index, 1);
    if (functionOffStage  == null ) {
			dispatchEvent(event);
			return;
		}
		functionOffStage.apply(null, argsOff);
	}
	
	/**
	* Adds a DisplayObject  to the DisplayObjectRepos	*/
	public function add(item:DisplayObject):void {
		displayObjectsRepos.push(item);
	}
	
	/* INTERFACE emBox.interfaces.IStartStop */
	
	public function get hasStarted():Boolean 
	{
		return _hasStarted;
	}
	
	public function set hasStarted(value:Boolean):void 
	{
		_hasStarted = value;
	}
	
}
}


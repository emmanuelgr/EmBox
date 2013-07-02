package emBox.commands.managers {
  import emBox.commands.ACommand;
  import emBox.commands.CAppear;
  import emBox.commands.CAppearAt;
  import emBox.commands.CEvent;
  import emBox.commands.COverlap;
  import emBox.commands.CParallel;
  import emBox.commands.CSetProperties;
  import emBox.interfaces.IThumb;
  import emBox.core.SoundPlayer;
  import emBox.dataObjects.ACollectionDispatcher;
  import emBox.EmBox;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;

/**
* Clicks update the local list
* @author Emmanuel
*/
public class CThumbsManager extends ACommand {
  private var mdl:ACollectionDispatcher;
  private var aSprite:Sprite;
  protected var container:DisplayObjectContainer;
  protected var instancesList:Array;
  protected var indexInInstanstanceList:int;
	protected var aThumb:IThumb;
	protected var seq:CParallel = new CParallel();

	public function CThumbsManager(
  mdl:ACollectionDispatcher,
  instancesList:Array,
  container:DisplayObjectContainer
  ) {
    this.mdl = mdl;
    this.instancesList = instancesList;
    this.container = container;
		super();
    customize();
  }
	
	protected function customize():void {
		for (var i:int = 0; i < instancesList.length; i++){
			aSprite = instancesList[i] as Sprite;
			seq.add(new CSetProperties(
      aSprite, { doubleClickEnabled: true ,buttonMode:true},
      aSprite, { doubleClickEnabled: false,buttonMode:false}
      ));
		}
	}
	
	override protected function doIn():void {
	  seq.addEventListener(CEvent.EXECUTE_IN_COMPLETE, executeInComplete)
    mdl.addEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		container.addEventListener(MouseEvent.CLICK, onSingleDoubleClick);
		container.addEventListener(MouseEvent.DOUBLE_CLICK, onSingleDoubleClick);
		container.addEventListener(MouseEvent.MOUSE_OVER, onOver);
		container.addEventListener(MouseEvent.MOUSE_OUT, onOut);
    seq.executeIn();// seq will call executeInComplete()
	}
	
	override protected function doOut():void {
	  seq.addEventListener(CEvent.EXECUTE_OUT_COMPLETE, executeOutComplete)
    mdl.removeEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		container.removeEventListener(MouseEvent.CLICK, onSingleDoubleClick);
		container.removeEventListener(MouseEvent.DOUBLE_CLICK, onSingleDoubleClick);
		container.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
		container.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
    seq.executeOut();// seq will call executeOutComplete()
	}
	
	protected function isClear(e:MouseEvent):Boolean {
    indexInInstanstanceList = instancesList.indexOf(e.target);
    //trace(e.target);
    //trace(indexInInstanstanceList);
		if (indexInInstanstanceList == -1) 	return false;
    aThumb = e.target as IThumb;
    if (aThumb == instancesList[mdl.pointer]) return false
    return true;
  }

	private function onSingleDoubleClick(e:MouseEvent):void {
    if (!isClear(e)) return;
		if (e.type == MouseEvent.DOUBLE_CLICK) onDoubleClick(e);
		if (e.type == MouseEvent.CLICK) 	onClick(e)
	}
	
	protected function onClick(e:MouseEvent):void {
    if (!isClear(e)) return;
		SoundPlayer.playSoundFx(EmBox.Sound_Clik);
		aThumb.hover.executeOut();
		mdl.pointer = instancesList.indexOf(e.target);
	}
	
	protected function onDoubleClick(e:MouseEvent):void {
    if (!isClear(e)) return;
		SoundPlayer.playSoundFx(EmBox.Sound_Clik);
		dispatchEvent(new Event(Event.CHANGE));
	}
	
	protected function onOver(e:MouseEvent):void {
    if (!isClear(e)) return;
    SoundPlayer.playSoundFx(EmBox.Sound_Over);
		aThumb.hover.executeIn();

		//var myClass:Class = Object(e.target).constructor;
		//var myThumbClass:Class = Object(aThumb).constructor;
		//trace()
		//trace(myClass)
		//trace(myThumbClass)
		//trace(myClass == myThumbClass)
		//trace("is Athumb " + (e.target is AThumb) )
		//trace()
		//if (!(e.target is AThumb)) {
			//return;
    //}
	}
	
	protected function onOut(e:MouseEvent):void {
    if (!isClear(e)) return;
		aThumb = e.target as IThumb;
		aThumb.hover.executeOut();
	}

	protected function onModelPointer(e:Event):void {
		if (mdl.pointerPrev >= 0) {
      aThumb = instancesList[mdl.pointerPrev] as IThumb;
			if (aThumb){
        if(aThumb.hightlight) aThumb.hightlight.executeOut();
        (aThumb as Sprite).buttonMode = true;
      }
		}
		if (mdl.pointer >= 0){
      aThumb = instancesList[mdl.pointer] as IThumb;
      if (aThumb) {
        if(aThumb.hightlight) aThumb.hightlight.executeIn();
        (aThumb as Sprite).buttonMode = false;
      }
		}
	}

}
}


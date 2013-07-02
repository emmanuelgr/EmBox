package emBox.commands.managers {
  import emBox.commands.ACommand;
  import emBox.commands.CAppear;
  import emBox.commands.CAppearAt;
  import emBox.commands.CEvent;
  import emBox.commands.COverlap;
	import emBox.commands.CParallel;
  import emBox.commands.CStartStop;
  import emBox.interfaces.ILoaderDO;
	import emBox.locations.ILocation;
  import emBox.sprites.EmBoxSprite;
  import emBox.core.SoundPlayer;
  import emBox.dataObjects.ACollectionDispatcher;
  import flash.events.Event;
  import flash.events.MouseEvent;

/**
* Clicks update the local list
* @author Emmanuel
*/
public class CLocationManager extends ACommand {
  protected var mdl:ACollectionDispatcher;
  protected var instancesList:Array;
  protected var indexInInstanstanceList:int;
	protected var anEmBoxSprite:EmBoxSprite;
	public var seq:COverlap = new COverlap();
  protected var location:ILocation;

	public function CLocationManager(
  mdl:ACollectionDispatcher,
  instancesList:Array,
  location:ILocation
  ) {
    this.mdl = mdl;
    this.instancesList = instancesList;
    this.location = location;
		super();
    customize();
	}
	
	protected function customize():void {
		var anEmBoxSprite:EmBoxSprite;
		for (var i:int = 0; i < instancesList.length; i++){
			anEmBoxSprite = instancesList[i] as EmBoxSprite;
      if(anEmBoxSprite is ILoaderDO){
				seq.add(new CStartStop((anEmBoxSprite as ILoaderDO).loaderDO));
			}
      seq.add(new CAppear(anEmBoxSprite, location.container, anEmBoxSprite.appears));
		}
	}
	
	override protected function doIn():void {
		location.offset = 0;
		location.refresh();
    mdl.addEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		location.container.addEventListener(Event.CHANGE, location.refresh);
	  seq.addEventListener(CEvent.EXECUTE_IN_COMPLETE, executeInComplete);
    seq.executeIn();
	}
	
	override protected function doOut():void {
    mdl.removeEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		location.container.removeEventListener(Event.CHANGE, location.refresh);
	  seq.addEventListener(CEvent.EXECUTE_OUT_COMPLETE, executeOutComplete);
    seq.executeOut();
	}
	
	protected function onModelPointer(e:Event):void {
		if (mdl.pointer >= 0){
      anEmBoxSprite = instancesList[mdl.pointer] as EmBoxSprite;
			location.offsetTo = mdl.pointer;
		}
	}

}
}


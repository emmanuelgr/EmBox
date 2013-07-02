package emBoxD6.commands.managers {
import com.google.analytics.GATracker;
import emBox.commands.ACommand;
import emBox.vos.VO;
import emBoxD6.vos.VODrupalNode;
import flash.display.Stage;
import emBox.dataObjects.*;
import flash.events.*;

/**
 * ...
 * @author emmanuel
 */
public class CGoogleAnalytics extends ACommand {
  private var stage:Stage;
  private var googleAnaluticsID:String ;
  private var googleAnaluticsIsDebugMode:Boolean;
  private var gaTracker:GATracker;
	private var aVO:VODrupalNode;
  private var voList:ACollectionDispatcher;
	
	/**
	 * @param voList the dispatcher
	 */
	public function CGoogleAnalytics(
  voList:ACollectionDispatcher,
  stage:Stage,
  googleAnaluticsID:String,
  googleAnaluticsIsDebugMode:Boolean = false
  ){
    this.voList = voList;
    this.stage = stage;
		this.googleAnaluticsID = googleAnaluticsID;
		this.googleAnaluticsIsDebugMode = googleAnaluticsIsDebugMode;
		super();
		init();
	}
	private function init():void {
		gaTracker = new GATracker( stage, googleAnaluticsID, "AS3", googleAnaluticsIsDebugMode);
	}
	
  override protected function doIn():void {
    voList.addEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		executeInComplete();
	}
	
	override protected function doOut():void {
    voList.removeEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		executeOutComplete();
	}
	
	private function onModelPointer(event:Event):void {
    aVO = voList.pointedObj as VODrupalNode;
    if (!aVO) return;
    trace("Send google: " + aVO.path);
    gaTracker.trackPageview(aVO.path);
	}
}
}


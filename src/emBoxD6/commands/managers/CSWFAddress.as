package emBoxD6.commands.managers {
import com.asual.swfaddress.*;
import emBox.commands.ACommand;
import emBox.vos.VO;
import emBoxD6.vos.VODrupalNode;


import emBox.dataObjects.*;

import flash.events.*;
import emBox.instanciators.AInstanciator;

/**
 * ...
 * @author emmanuel
 */
public class CSWFAddress extends ACommand {
	private var aVO:VODrupalNode;
	private var forceToURL:String;
  private var swfTitle:String;
  private var swfAddReqIndex:int;
  private var requestedSWFAdddressPath:String;
  private var voList:ACollectionDispatcher;
	
	/**
	 * @param voList the dispatcher
	 * @param swfTitle prepended  text to set the title of the html tab
	 * @param	forceToURL usually "/home"
	 */
	public function CSWFAddress(
  voList:ACollectionDispatcher,
  swfTitle:String,
  forceToURL:String = null
  ){
    this.voList = voList;
    this.swfTitle = swfTitle;
		this.forceToURL = forceToURL;
		super();
	}
	
	override protected function doIn():void {
    SWFAddress.addEventListener(SWFAddressEvent.CHANGE, onSWFAddressChange);
    voList.addEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
    executeInComplete();
    if (forceToURL) {
			SWFAddress.setValue(forceToURL);
		}
	}

	override protected function doOut():void {
    SWFAddress.removeEventListener(SWFAddressEvent.CHANGE, onSWFAddressChange);
    voList.removeEventListener(ACollectionDispatcher.SET_POINTER_TRIGGERED, onModelPointer);
		executeOutComplete();
	}
	
  private function onModelPointer(e:Event):void {
    /// Inform swfaddress about our change
    aVO = voList.pointedObj as VODrupalNode
    if (aVO ) {
      trace("voList pointedObj.path: " + aVO.path);
      ///set the title of the html tab
      SWFAddress.setTitle( swfTitle + aVO.path);
      SWFAddress.setValue( String(aVO.path))
    }else {
      SWFAddress.setTitle( swfTitle );
      SWFAddress.setValue("")
    }
  }

	private function onSWFAddressChange(e:SWFAddressEvent):void {
		///Remove sladh "/ "added by swf address
		requestedSWFAdddressPath = e.path;
		requestedSWFAdddressPath = requestedSWFAdddressPath.substring(1);
    trace(">>>>>>>>requestedSWFAdddressPath after: " + requestedSWFAdddressPath);
    /// if swfAdress requested path is the same wit the aVO.path then ignore
    aVO = voList.pointedObj as VODrupalNode;
    if ( aVO && aVO.path == requestedSWFAdddressPath) return;
    /// its a browaer navigation request so Fetch the VO obj by providing list the path from the swf event
    var swfAddReqVO:VO = voList.objectByPropertyWithValue("path", requestedSWFAdddressPath) as VO;
    /// Update voList model
    var swfAddReqVOIndex:int = voList.list.indexOf(swfAddReqVO);
    voList.pointer = swfAddReqVOIndex;
	}
	

}
}


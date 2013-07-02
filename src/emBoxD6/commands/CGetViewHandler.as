package emBoxD6.commands  {

import emBox.instanciators.InstanciatorMapper;
import emBoxD6.vos.VODrupalNode;

import emBox.commands.*;
import emBox.dataObjects.*;

import flash.events.*;

/**
 * Creates Vos for all raw data request
 * @author Emmanuel
 */
public class CGetViewHandler extends ACommand {
  private var mappper:InstanciatorMapper;

  public function CGetViewHandler(
  mappper:InstanciatorMapper
  ) {
    this.mappper = mappper;
    super();
  }

  override protected function doIn():void {
    super.doIn();
    trace();
    trace("Running CGetViewHandler...");
    trace("------------------------");
    var rawData:Array = [];
    var aRawData:Object;

    /* Check returned data is a single object or an Array*/
    if (CEvent(eventIn).data is Array) {
      for (var k:int = 0; k < CEvent(eventIn).data.length; k++) {
        aRawData = (CEvent(eventIn).data as Array)[k];
        rawData.push( aRawData);
      }
    }else rawData.push( CEvent(eventIn).data);
    
    mappper.source = rawData;
    //mappper.populateAllInstances();
    trace("CGetViewHandler done, IMPORTANT >call its mappper.populateAllInstances()")
    executeInComplete();
  }

}
}


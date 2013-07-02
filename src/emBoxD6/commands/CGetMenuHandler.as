package emBoxD6.commands {
import emBox.utils.Objects;
import emBoxD6.vos.VOMenu;

import emBox.commands.ACommand;
import emBox.commands.CEvent;
import emBox.dataObjects.*;

public class CGetMenuHandler extends ACommand {
	private var menuList:ACollectionDispatcher;
	private var aRawData:Object;
	private var ignoreHidden:Boolean;
	
	/**
	* Builds VOMenus needs to be paired with CGetMenu,
	* @author Emmanuel
	* @param	menuList a ACollectionDispatcher to store the information returned from Drupal
	* @param	ignoreHidden usefull when nodehiearchy is used
	*/
	public function CGetMenuHandler(menuList:ACollectionDispatcher, ignoreHidden:Boolean = true){
		this.menuList = menuList;
		this.ignoreHidden = ignoreHidden;
	}
	
	override protected function doIn():void {
		super.doIn();
		trace();
		trace("Running CGetMenuHandler ");
		trace("------------------------");
		var rawData:Array = CEvent(eventIn).data as Array;
		for (var i:int = 0; i < rawData.length; i++){
			traverse(rawData[i]);
		}
		executeInComplete();
	}
	
	///  Store in menuList
	private function traverse(aRawData:Object, papa:VOMenu = null):VOMenu {
		if (ignoreHidden && aRawData.hidden == "1")			return null;
    
		var voMenu:VOMenu = new VOMenu(aRawData, papa);
		if (aRawData.hasOwnProperty("children")){
			for (var k:int = 0; k < aRawData.children.length; k++){
				var returnedVOMenu:VOMenu = traverse(aRawData.children[k], voMenu);
				if (returnedVOMenu)
					voMenu.children.push(returnedVOMenu);
			}
		}
		menuList.list.push(voMenu);
		return voMenu;
	}

}
}
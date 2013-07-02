package emBoxD6.commands {
import emBox.instanciators.InstanciatorMapper;
import emBox.utils.Objects;
import emBox.vos.VO;
import emBoxD6.EmBoxD6;
import emBoxD6.vos.VOMenu;

import emBox.commands.ACommand;
import emBox.commands.CEvent;
import emBox.dataObjects.*;

public class CGetEmboxd6Handler extends ACommand {
	private var menuList:ACollectionDispatcher;
  private var voList:ACollectionDispatcher;
	private var aRawData:Object;
	private var ignoreHidden:Boolean;
	private var vosMapper:InstanciatorMapper;
	private var instancesMapper:InstanciatorMapper;
  
	/**
	* Builds VOMenus needs to be paired with CGetMenu,
	* @author Emmanuel
	* @param	menuList a ACollectionDispatcher to store the information returned from Drupal
	* @param	ignoreHidden usefull when nodehiearchy is used
	*/
	public function CGetEmboxd6Handler(
  menuList:ACollectionDispatcher,
  voList:ACollectionDispatcher,
  vosMapper:InstanciatorMapper,
  instancesMapper:InstanciatorMapper,
  ignoreHidden:Boolean = true
  ){
		this.menuList = menuList;
		this.voList = voList;
    this.vosMapper = vosMapper;
    this.instancesMapper = instancesMapper;
		this.ignoreHidden = ignoreHidden;
	}
	
	override protected function doIn():void {
		super.doIn();
		trace();
		trace("Running CBuildSitesDataFromEmBoxD6RawData ");
		var rawData:Object = CEvent(eventIn).data;
    
    /// sites data
    EmBoxD6.vocabularies = rawData["vocabularies"];
    EmBoxD6.sitesFront = rawData["site_frontpage"];
    EmBoxD6.sitesName = rawData["site_name"];
    EmBoxD6.sitesEmail = rawData["site_mail"];
    EmBoxD6.sitesSlogan = rawData["site_slogan"];
    EmBoxD6.sitesMission = rawData["site_mission"];
    EmBoxD6.sitesFooterMessage = rawData["site_footer"];
    
    /// do menu
		var menu:Array = rawData["menu"] as Array;
		for (var i:int = 0; i < menu.length; i++){
			traverse(menu[i]);
		}
    ///  Store in menuList
    function traverse(aRawData:Object, papa:VOMenu = null):VOMenu {
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
    
    /// set source for vo mapper
    // add all nodes from service
    for (var k:int = 0; k < rawData["nodes"].length; k++) {
      var node:Object = rawData["nodes"][k];
      vosMapper.source.push( node);
    }
    vosMapper.populateAllInstances();
    
    instancesMapper.populateAllInstances();
		executeInComplete();
	}
	

}
}
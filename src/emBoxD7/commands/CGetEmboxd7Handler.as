package emBoxD7.commands {
import emBox.instanciators.InstanciatorMapper;
import emBox.utils.ArraysVectors;
import emBox.utils.Objects;
import emBox.vos.VO;
import emBoxD7.EmBoxD7;
import emBoxD7.vos.VOMenu;

import emBox.commands.ACommand;
import emBox.commands.CEvent;
import emBox.dataObjects.*;

public class CGetEmboxd7Handler extends ACommand {
	private var menuList:ACollectionDispatcher;
  private var voList:ACollectionDispatcher;
	private var aRawData:Object;
	private var ignoreHidden:Boolean;
	private var vosMapper:InstanciatorMapper;
	private var instancesMapper:InstanciatorMapper;
  private var menuListGr:Vector.<VOMenu>= new Vector.<VOMenu>();
  
	/**
	* Builds VOMenus needs to be paired with CGetMenu,
	* @author Emmanuel
	* @param	menuList a ACollectionDispatcher to store the information returned from Drupal
	* @param	ignoreHidden usefull when nodehiearchy is used
	*/
	public function CGetEmboxd7Handler(
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
		trace("Running CGetEmboxd7Handler ");
		var rawData:Object = CEvent(eventIn).data;
    
    /// sites taxonomy
    EmBoxD7.vocabularies = rawData["vocabularies"];
    EmBoxD7.terms = rawData["terms"];
    /// sites data
    EmBoxD7.sitesFront = rawData["site_frontpage"];
    EmBoxD7.sitesName = rawData["site_name"];
    EmBoxD7.sitesEmail = rawData["site_mail"];
    EmBoxD7.sitesSlogan = rawData["site_slogan"];
    EmBoxD7.sitesMission = rawData["site_mission"];
    EmBoxD7.sitesFooterMessage = rawData["site_footer"];
    /// do menu
		var menu:Array = rawData["menu"] as Array;
		for (var i:int = 0; i < menu.length; i++){
			traverse(menu[i]);
		}
    ///  Store in menuList
    function traverse(aRawData:Object, papa:VOMenu = null):VOMenu {
      if (ignoreHidden && aRawData.hidden == "1")			return null;
      
      var voMenu:VOMenu = new VOMenu(aRawData, papa);
      if (voMenu.language=="el") {
        menuListGr.push(voMenu);
      }else {
        menuList.list.push(voMenu);
      }
      
      if (aRawData.hasOwnProperty("children")){
        for (var k:int = 0; k < aRawData.children.length; k++){
          var returnedVOMenu:VOMenu = traverse(aRawData.children[k], voMenu);
          if (returnedVOMenu)
            voMenu.children.push(returnedVOMenu);
        }
      }
      return voMenu;
    }
    
    /// add greek inf0
    for (var j:int = 0; j < menuListGr.length; j++) {
      var aGr:VOMenu = menuListGr[j];
      var aEn:VOMenu = menuList.objectByPropertyWithValue( "href", aGr.href) as VOMenu;
      if (aGr && aEn) {
        aEn.titleGreek = aGr.title;
        aEn.descriptionGreek = aGr.description;
      }
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
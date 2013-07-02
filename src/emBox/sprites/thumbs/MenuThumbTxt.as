package emBox.sprites.thumbs {
import emBox.commands.ACommand;
import emBox.commands.CParallel;
import emBox.commands.CSetProperties;
import emBox.commands.vfxs.VFXFade;
import emBox.commands.vfxs.VFXTint;
import emBox.EmBox;
import emBox.interfaces.IClonable;
import emBox.interfaces.IThumb;
import emBox.sprites.textFields.Label;
import emBoxD6.vos.VOMenu;
import flash.text.TextFormat;

/**
 * ...
 * @author Emmanuel Vohaitis
 */
public class MenuThumbTxt extends Label implements IThumb {
  protected var voMenu:VOMenu;
  private var _hover:ACommand;
  private var _hightlight:ACommand;
	
	public function MenuThumbTxt(
  voMenu:VOMenu,
  textFormat:TextFormat,
  nineGrid:String = null
  ) {
    this.voMenu = voMenu;
    this.textFormat = textFormat;
    //if(voMenu) {
      //label = new Label(voMenu.title, textFormat, nineGrid);
    //}else {
      //label = new Label("null", textFormat, nineGrid);
    //}
    var t:String = "null";
    if ( voMenu && voMenu.title) t = voMenu.title;
    super( t, textFormat, nineGrid);
    
    mouseEnabled = true;
    
    appears = new VFXFade(this, 0, 0.8, 1);
    _hover = new CParallel(
    new CSetProperties( this.filters, { alpha:0}, this.filters, {alpha:1}),
    new VFXTint(this, EmBox.Color_Ac, 0.1)
    );
    _hightlight = new VFXTint(this, EmBox.Color_AcL2, 0.1);
    filters= [ EmBox.dropShadowSml]
	}
	
  override public function clone(vars:Object = null):IClonable {
    //trace((vars is VOMenu))
		return new MenuThumbTxt(
     (vars is VOMenu)?vars as VOMenu:voMenu,
     (vars.hasOwnProperty("textFormat"))?vars.textFormat:textFormat,
		 (vars.hasOwnProperty("nineGrid"))?vars.nineGrid:nineGrid
    );
	}

  public function get hover():ACommand {  return _hover}
  public function set hover(value:ACommand):void {  
    _hover = value;
  }
  public function get hightlight():ACommand {  return _hightlight}
  public function set hightlight(value:ACommand):void {  
    _hightlight = value;
  }
}
}
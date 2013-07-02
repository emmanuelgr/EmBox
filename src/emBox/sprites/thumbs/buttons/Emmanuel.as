package emBox.sprites.thumbs.buttons {
  import com.greensock.easing.*;
  import emBox.*;
  import emBox.actions.Interactivable;
  import emBox.commands.*;
  import emBox.commands.vfxs.*;
  import emBox.core.*;
  import emBox.interfaces.IStartStop;
  import emBox.sprites.icons.*;
  import emBox.locations.*;
  import emBox.sprites.textFields.*;
  import flash.display.*;
  import flash.events.*;
  import flash.geom.*;
  import flash.net.*;
  import emBox.sprites.EmBoxSprite;
  import emBox.shapes.EmBoxShape;

/**
 * ...
 * @author Emmanuel
 */
public class Emmanuel extends EmBoxSprite implements IStartStop{


  [Embed(source = '../../../../../resources/dcc/images/Design-by-Emmanuel-design-by.png')]
  private	var DesignbyPNG:Class;

  [Embed(source = '../../../../../resources/dcc/images/Design-by-Emmanuel-emmanuel.gr.png')]
  private	var EmmanuelPNG:Class;


  private	var GREEN_DARK:uint = 0x34411A;
  private	var GREEN_LIGHT:uint = 0x9AB72F;
  private	var BROWN:uint = 0x181005;
  private	var WHITE:uint = 0xDDE1C7;
  private var _hasStarted:Boolean = false;
  private var interactivable:Interactivable;
  private var hover:COverlap;

  public function Emmanuel(){
    
    var bRec:EmBoxSprite = new EmBoxSprite( 8, 8, NineGrid.MiddleMiddle, GREEN_LIGHT, 1);
    var sRec:EmBoxShape = new EmBoxShape( 4, 4, NineGrid.MiddleMiddle, GREEN_DARK, 1);
    bRec.addChild( sRec );
    bRec.x = -13;
    bRec.y = -13;
    this.addChild(bRec);

    var design:Bitmap = new DesignbyPNG() as Bitmap;
    design.x = -50;
    design.y = -20;
    design.alpha = 0;

    var emm:Bitmap = new EmmanuelPNG() as Bitmap;
    emm.x = -50;
    emm.y = -13;
    emm.alpha = 0;


    hover = new COverlap();
    ( hover as COverlap ).delayIn = 0.03;
    ( hover as COverlap ).add(
      new CTweenLiteTo( this,
       0.5, { width:166,transparency:1, ease:Quint.easeOut },
       0.3, { width:26, transparency:0,ease:Quint.easeIn }
      )
    );
    ( hover as COverlap ).add(
      new CTweenLiteTo(bRec,
       0.8, { x:-153,  width:14, height:14, ease:Bounce.easeOut },
       0.3, { x:-13 ,  width:8, height:8, ease:Quint.easeIn }
      )
    );
    ( hover as COverlap ).add(
      new CTweenLiteTo(sRec,
       1.7, { width:8, height:8, ease:Bounce.easeOut },
       0.3, { width:4, height:4, ease:Bounce.easeIn }
      )
    );
    ( hover as COverlap ).add( new CAddRemoveChild(this, design));
    ( hover as COverlap ).add(
      new CTweenLiteTo(design,
       0.8, { x:-144, alpha:1, ease:Bounce.easeOut },
       0.2, { x:-50 , alpha:0, ease:Quint.easeIn }
      )
    );
    ( hover as COverlap ).add( new CAddRemoveChild(this, emm));
    ( hover as COverlap ).add(
      new CTweenLiteTo(emm,
       1.2, {x:-144,alpha:1, ease:Bounce.easeOut },
       0.2, {x:-50 ,alpha:0, ease:Quint.easeIn }
      )
    );
    
    
    super(26, 26, NineGrid.LowerRight, BROWN, 0);
    interactivable = new Interactivable(this, onClick, null,null,null, hover.executeIn, hover.executeOut);
  }
  
  /* INTERFACE emBox.interfaces.IStartStop */
  
  public function get hasStarted():Boolean {    return _hasStarted;  }
    public function set hasStarted(value:Boolean):void {
    _hasStarted = value;
  }
  
  public function start(e:Event = null):void {
    interactivable.start();
  }
  
  public function stop(e:Event = null):void {
    interactivable.stop();
    
  }

  private function onClick(event:MouseEvent=null):void {
    var request:URLRequest = new URLRequest("http://www.emmanuel.gr");
    try  {	navigateToURL(request, "_blank");}
    catch (e:Error) 	{ trace("Error occurred!");}
  }

}
}
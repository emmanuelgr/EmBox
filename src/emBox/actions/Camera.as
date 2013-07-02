package emBox.actions {
  import com.greensock.*;
  import com.greensock.easing.*;
  import emBox.core.*;
  import emBox.EmBox;
  import emBox.sprites.icons.Trident10;
  import emBox.locations.*;
  import emBox.utils.*;
  import flash.display.*;
  import flash.events.*;
  import flash.geom.*;
  import flash.utils.*;
  import emBox.sprites.EmBoxSprite;

	/**
	 * ...Rotates a sprite acording to mouse postiotion
	 * psedo camera setup
	 * @author Emmanuel
	 */
	public class Camera extends OnOffStage{
		private var container:Sprite;
		private var rotGapX:Number;
		private var rotGapY:Number;
		private var mouseVelX:Number;
		private var mouseVelY:Number;
		private var rotDestX:Number;
		private var rotDestY:Number;
		private var mouseOffScreen:Boolean;
		public var sort:Boolean;
    private var offsetRotX:Number;
    private var offsetRotY:Number;
	private var fov:Number;
    private var projectionCentrOffsetX:Number;
    private var projectionCentrOffsetY:Number;
    private var offScreenPose:Object;

		public function Camera(
		container:Sprite,
		rotGapX:Number,
		rotGapY:Number,
		fov:Number = 55,
		projectionCentrOffsetX:Number = 0,
		projectionCentrOffsetY:Number = 0,
    offsetRotX:Number = 0,
    offsetRotY:Number = 0,
		sort:Boolean = false,
		debug:Boolean = false,
    offScreenPose:Object= null
		){
      this.container = container;
			this.rotGapX = rotGapX;
			this.rotGapY = rotGapY;
      this.fov = fov;
      this.projectionCentrOffsetX = projectionCentrOffsetX;
			this.projectionCentrOffsetY = projectionCentrOffsetY;
      this.offsetRotX = offsetRotX;
      this.offsetRotY = offsetRotY;
			this.sort = sort;
      this.offScreenPose = offScreenPose?offScreenPose:{ rotationX:30,rotationY:-30,ease:Expo.easeOut	};
			super( container, onStage, null, offStage);
			init();
      if (debug) this.debug();
		}
		public function init(e:Event = null):void {
      container.transform.perspectiveProjection = new PerspectiveProjection();
      container.transform.perspectiveProjection.projectionCenter = new Point( EmBox.sWCntr,EmBox.sHCntr);
      //container.transform.perspectiveProjection.projectionCenter = new Point( 0,0);
      container.transform.perspectiveProjection.fieldOfView = fov;
      container.transform.perspectiveProjection.projectionCenter.x += projectionCentrOffsetX;
      container.transform.perspectiveProjection.projectionCenter.y += projectionCentrOffsetY;
			onMouseOffScreen();
		}

		private function onStage(e:Event = null):void {
			container.addEventListener(Event.ENTER_FRAME,  onFrame);
			container.stage.addEventListener(Event.MOUSE_LEAVE,  onMouseOffScreen);
			container.stage.addEventListener(Event.RESIZE,  init);
			container.stage.addEventListener(Event.FULLSCREEN,  init);
		}

		private function offStage(e:Event = null):void {
			container.removeEventListener(Event.ENTER_FRAME,  onFrame);
			container.stage.removeEventListener(Event.MOUSE_LEAVE,  onMouseOffScreen);
      container.stage.removeEventListener(Event.RESIZE,  init);
			container.stage.removeEventListener(Event.FULLSCREEN,  init);
		}

		private function onFrame(e:Event):void {
			moveCam();
			if(sort) DisplayObjectContainers.sortClips( container);
		}
		private function moveCam():void {

			if ( mouseOffScreen ) return;
      mouseVelX = (container.stage.mouseX ) / (container.stage.width );
      mouseVelX = -Maths.get10_1(mouseVelX);
      mouseVelY = (container.stage.mouseY )/ (container.stage.height);
      mouseVelY = Maths.get10_1(mouseVelY);
      //rotDestX = mouseVelY * rotGapX - rotGapHalfX ;
      //rotDestX = -rotDestX;
      //rotDestY =  mouseVelX * rotGapY - rotGapHalfY ;
      //container.rotationX += ( rotDestX - container.rotationX )/12;
      //container.rotationY += ( rotDestY - container.rotationY) / 12;
      // straight  implementation
      //container.rotationX = mouseVelY * rotGapX - rotGapHalfX ;
      //container.rotationY = mouseVelX * rotGapY - rotGapHalfY ;

      TweenLite.to(container, 2, {
        rotationX:(mouseVelY * rotGapX + offsetRotX),
        rotationY:(mouseVelX * rotGapY + offsetRotY) ,
        ease:Expo.easeOut
      });
		}
		public function reset(e:Event = null):void {
			TweenLite.to(container, 2, {
				rotationX:0,
				rotationY:0,
				ease:Expo.easeOut
			});
			offStage();
		}
		private function onMouseOffScreen(e:Event = null):void {
			mouseOffScreen = true;
			container.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseOnScreen);
      container.rotationY ++;
			TweenLite.to(container, 2, offScreenPose);
			function onMouseOnScreen(e:MouseEvent):void {
				mouseOffScreen = false;
				container.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseOnScreen);
			}
		}

    private function debug():void {
      container.addChild( new Trident10());

      var fV:EmBoxSprite = new EmBoxSprite( 50, 50, null, 0x112233);
      new ConstrainToStage(fV, NineGrid.MiddleRight, NineGrid.MiddleRight, false, 0, -25).start();
      container.stage.addChild(fV)
      fV.addEventListener(MouseEvent.MOUSE_WHEEL,  function a(e:MouseEvent):void {
        container.transform.perspectiveProjection.fieldOfView = Maths.clamp(  container.transform.perspectiveProjection.fieldOfView + e.delta, 1, 179);
        trace("fieldOfView "+ container.transform.perspectiveProjection.fieldOfView)
      } );

      var prjCntrX:EmBoxSprite = new EmBoxSprite( 50, 50, null, 0xff0000);
      new ConstrainToStage(prjCntrX, NineGrid.LowerRight, NineGrid.LowerRight, false, -50, 0-100).start();
      container.stage.addChild(prjCntrX);
      prjCntrX.addEventListener(MouseEvent.MOUSE_WHEEL,  function a(e:MouseEvent):void {
        container.transform.perspectiveProjection.projectionCenter = new Point(
        container.transform.perspectiveProjection.projectionCenter.x + e.delta,
        container.transform.perspectiveProjection.projectionCenter.y
        );
        trace("projectionCenter.x " + container.transform.perspectiveProjection.projectionCenter.x);
      } );

      var prjCntrY:EmBoxSprite = new EmBoxSprite( 50, 50, null, 0x00ff00);
      new ConstrainToStage(prjCntrY, NineGrid.LowerRight, NineGrid.LowerRight, false, 0, -50-100).start();
      container.stage.addChild(prjCntrY);
      prjCntrY.addEventListener(MouseEvent.MOUSE_WHEEL,  function a(e:MouseEvent):void {
        container.transform.perspectiveProjection.projectionCenter = new Point(
        container.transform.perspectiveProjection.projectionCenter.x ,
        container.transform.perspectiveProjection.projectionCenter.y+ e.delta
        );
        trace("projectionCenter.y " + container.transform.perspectiveProjection.projectionCenter.y)
      } );

      var rotOffsetX:EmBoxSprite = new EmBoxSprite( 50, 50, null, 0xff6666);
      new ConstrainToStage(rotOffsetX, NineGrid.LowerLeft, NineGrid.LowerLeft, false, 50, 0-100).start();
      container.stage.addChild(rotOffsetX);
      rotOffsetX.addEventListener(MouseEvent.MOUSE_WHEEL,  function a(e:MouseEvent):void {
        offsetRotX += e.delta;
        trace("offsetRotX "+ offsetRotX)
      } );

      var rotOffsetY:EmBoxSprite = new EmBoxSprite( 50, 50, null, 0x66ff66);
      new ConstrainToStage(rotOffsetY, NineGrid.LowerLeft, NineGrid.LowerLeft, false, 0, -50-100).start();
      container.stage.addChild(rotOffsetY);
      rotOffsetY.addEventListener(MouseEvent.MOUSE_WHEEL,  function a(e:MouseEvent):void {
        offsetRotY += e.delta;
        trace("offsetRotY "+ offsetRotY)
      } );

      var contaierZ:EmBoxSprite = new EmBoxSprite( 50, 50, null, 0x665544);
      new ConstrainToStage(contaierZ, NineGrid.LowerMiddle, NineGrid.LowerMiddle, false, 0, -100).start();
      container.stage.addChild(contaierZ);
      contaierZ.addEventListener(MouseEvent.MOUSE_WHEEL,  function a(e:MouseEvent):void {
        container.z += e.delta;
        trace("container.z "+ container.z)
      } );
    }

	}
}


package emBox.shapes{
	import emBox.interfaces.IClonable;
	import flash.display.Shape;

	public class Trident extends Rectangle {

		public function Trident() {
      super( 20, 20 );
		}
    
    override protected function draw():void {
      graphics.clear();
      graphics.beginFill(0x661111);
			graphics.drawRect( 0, 0, 20, 1);
			graphics.beginFill(0x116611);
			graphics.drawRect(0,0,1,20);
			graphics.beginFill(0x111166);
			graphics.drawCircle(0, 0, 2);
			graphics.endFill();
    }
    
		override public function clone( vars:Object = null):IClonable{
			return new Trident( );
		}
    
	}
}


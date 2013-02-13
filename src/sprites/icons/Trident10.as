package emBox.sprites.icons{
    import emBox.shapes.EmBoxShape;
    import emBox.core.NineGrid;
    import flash.display.Sprite;
    

	/**
	 * ...
	 * @author emmanuel
	 */
	public class Trident10 extends Sprite	{
		private var origin:Sprite;
		private var axisX:EmBoxShape;
		private var axisY:EmBoxShape;
		private var axisZ:EmBoxShape;

		private var yellow:uint;
		private var red:uint;
		private var green:uint;
		private var blue:uint;
		
		public function Trident10(){
			super();
			yellow = 0xD7AB26;
			red = 0x751f11;
			green = 0x517b36;
			blue = 0x36677b;
			
			axisX = new EmBoxShape(30, 5, NineGrid.MiddleLeft, red,   1 );
			axisY = new EmBoxShape(30, 5, NineGrid.MiddleLeft, green, 1 );
			axisZ = new EmBoxShape(30, 5, NineGrid.MiddleLeft, blue,  1 );
			origin =  new Cube10Constant(6, yellow,1);
      
			
			addChild(axisZ);	
			addChild(axisX);
			addChild(axisY);
			addChild(origin);
      
			axisX.x = 6;
			axisY.y = 6;
			axisZ.z = 6;
      
			axisY.rotationZ = 90;
			axisZ.rotationX = 90;
			axisZ.rotationY = -90;
		}
		
	}

}
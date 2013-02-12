package gr.emmanuel.shapes{
import gr.emmanuel.interfaces.IClonable;
import gr.emmanuel.core.NineGrid;
import gr.emmanuel.utils.Maths;
import flash.display.*;
import gr.emmanuel.utils.Colors;


public class Busy extends Rectangle{
	private var radius:Number;
	private var totalCircles:Number;
	private var smlCircleRadius:Number;
	
	public function Busy(
		radius:Number = 20,
		totalCircles:Number = 9,
		smlCircleRadius:Number = 3,
		color:Number = NaN
	){
		this.radius = radius;
		this.totalCircles = totalCircles;
		this.smlCircleRadius = smlCircleRadius;
		color = isNaN(color)? Colors.Color_Fg:color;
		super( radius*2, radius*2, NineGrid.MiddleMiddle, color);
	}
	
	override protected function draw():void {
		graphics.clear();
		for (var i:int = 0; i < totalCircles; i++){
			graphics.beginFill(color, (i+1)/totalCircles);
			graphics.drawCircle(
				Math.cos(i/totalCircles * Maths.twoPi)*radius,
				Math.sin(i/totalCircles * Maths.twoPi)*radius,
				smlCircleRadius );
			graphics.endFill();
		}
	}
	
	override public function clone( vars:Object = null):IClonable{
		return new Busy(
			(vars.hasOwnProperty("radius"))?vars.radius:radius,
			(vars.hasOwnProperty("totalCircles"))?vars.totalCircles:totalCircles,
			(vars.hasOwnProperty("color"))?vars.color:color
		);
	}
	
}
}


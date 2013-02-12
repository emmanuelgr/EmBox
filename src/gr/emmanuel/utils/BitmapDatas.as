package gr.emmanuel.utils {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.BitmapDataChannel;
import flash.display.DisplayObject;
import flash.filters.BitmapFilter;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
import gr.emmanuel.core.AspectRatio;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * ...
 * @authrz emmanuel
 */
public class BitmapDatas {
	private static var aspectRatio:AspectRatio;
	private static var matrix:Matrix;
	private static var tempBD:BitmapData;
	
	public function BitmapDatas() {
	}
	
	public static function resize(bmD:BitmapData, desiredWidth:int, desiredHeight:int, aspectRatioString:String, transparent:Boolean = true, fillColor:uint = 0xffffff, smoothing:Boolean = true):BitmapData {
		aspectRatio = new AspectRatio(aspectRatioString, desiredWidth, desiredHeight, bmD.width, bmD.height);
		matrix = new Matrix();
		matrix.scale(aspectRatio.ratioW, aspectRatio.ratioH);
		
		switch (aspectRatioString) {
			
			case AspectRatio.MAINTAIN: 
				tempBD = new BitmapData(Math.min(desiredWidth, bmD.width * aspectRatio.ratioW), Math.min(desiredHeight, bmD.height * aspectRatio.ratioH), transparent, fillColor);
				tempBD.draw(bmD, matrix, null, null, null, smoothing);
				break;
			
			case AspectRatio.CROP:
				tempBD = new BitmapData(desiredWidth, desiredHeight, transparent, fillColor);
				
				///   this works as well >>>>>> instead of BBBB
				//var destinationPoint:Point = new Point();
				//var srcRect:Rectangle = new Rectangle(0, 0, desiredWidth, desiredHeight);
				//if (bmD.width/ bmD.height  < desiredWidth/desiredHeight) {
					//srcRect.x = (bmD.width - desiredWidth) * 0.5;
					//srcRect.y = (bmD.height - desiredHeight) * 0.5;
				//} else {
					//destinationPoint.x = (desiredWidth - bmD.width) * 0.5;
					//destinationPoint.y = (desiredHeight - bmD.height) * 0.5;
				//}
				//tempBD.copyPixels(bmD, srcRect, destinationPoint);
				///   this works as well <<<<
				
				///   this works as well >>>>>> instead of BBBB
				//var destinationPoint:Point = new Point();
				//var srcRect:Rectangle = new Rectangle(0, 0, desiredWidth, desiredHeight);
				//if (bmD.width > desiredWidth) {
					//srcRect.x = (bmD.width - desiredWidth) * 0.5;
				//} else {
					//destinationPoint.x = (desiredWidth - bmD.width) * 0.5;
				//}
				//if (bmD.height > desiredHeight) {
					//srcRect.y = (bmD.height - desiredHeight) * 0.5;
				//} else {
					//destinationPoint.y = (desiredHeight - bmD.height) * 0.5;
				//}
				//tempBD.copyPixels(bmD, srcRect, destinationPoint);
				///   this works as well <<<<
				
				///   this works as well >>>>>> instead of BBBB
				//var bmdScaledAsmUCH:BitmapData = new BitmapData(aspectRatio.width, aspectRatio.height, transparent, fillColor);
				//bmdScaledAsmUCH.draw(bmD, matrix, null, null, null, smoothing);
				//var destinationPoint:Point = new Point();
				//var srcRect:Rectangle = new Rectangle(0, 0, desiredWidth, desiredHeight);
				//if (aspectRatio.width > desiredWidth) {
					//srcRect.x = (aspectRatio.width - desiredWidth) * 0.5;
				//} else {
					//destinationPoint.x = (desiredWidth - aspectRatio.width) * 0.5;
				//}
				//if (aspectRatio.height > desiredHeight) {
					//srcRect.y = (aspectRatio.height - desiredHeight) * 0.5;
				//} else {
					//destinationPoint.y = (desiredHeight - aspectRatio.height) * 0.5;
				//}
				//tempBD.copyPixels(bmdScaledAsmUCH, srcRect, destinationPoint);
				///   this works as well <<<<
				
				//// 				BBBB >>>>
				matrix.translate((desiredWidth - aspectRatio.width) * 0.5,  (desiredHeight - aspectRatio.height) * 0.5);
				var bmdScaledAsmUCH:BitmapData = new BitmapData(aspectRatio.width, aspectRatio.height, transparent, fillColor);
				bmdScaledAsmUCH.draw(bmD, matrix, null, null, null, smoothing);
				tempBD.copyPixels(bmdScaledAsmUCH, new Rectangle(0, 0, desiredWidth, desiredHeight), new Point());
				//// 				BBBB <<<<
				break;
			
			case AspectRatio.FIT: 
				
				tempBD = new BitmapData(desiredWidth, desiredHeight, transparent, fillColor);
				tempBD.draw(bmD, matrix, null, null, null, smoothing);
				break;
		}
		
		return tempBD;
	}
	
	/**
	 * Takes a rgb image and matte (black n white image)
	 * to return new bitmap with alpha
	 * @param	rgb
	 * @param	a
	 * @return
	 */
	public static function toRGBA(rgb:Bitmap, a:Bitmap):Bitmap {
		var bmd:BitmapData = new BitmapData(rgb.bitmapData.width, rgb.bitmapData.height);
		bmd.copyChannel(rgb.bitmapData, rgb.bitmapData.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.RED);
		bmd.copyChannel(rgb.bitmapData, rgb.bitmapData.rect, new Point(), BitmapDataChannel.GREEN, BitmapDataChannel.GREEN);
		bmd.copyChannel(rgb.bitmapData, rgb.bitmapData.rect, new Point(), BitmapDataChannel.BLUE, BitmapDataChannel.BLUE);
		bmd.copyChannel(a.bitmapData, a.bitmapData.rect, new Point(), BitmapDataChannel.BLUE, BitmapDataChannel.ALPHA);
		return new Bitmap(bmd);
	}
	
	public static function repeatFill(source:BitmapData, target:BitmapData):void {
		var quotient_W:Number = target.width / source.width;
		var quotient_H:Number = target.height / source.height;
		
		target.fillRect(target.rect, 0x000000);
		for (var i:int = 0; i < quotient_H; i++) {
			for (var j:int = 0; j < quotient_W; j++) {
				target.copyPixels(source, source.rect, new Point(j * source.width, i * source.height), null, null, true);
			}
		}
	
	}
	
	public static function wrapBD(tileableBD:BitmapData, target:BitmapData, u:Number = 0, v:Number = 0):void {
		u = Maths.wrap(u, 1), 1;
		v = Maths.wrap(v, 1), 1;
		
		var uA:Number = Math.floor(tileableBD.width * u);
		var uB:Number = tileableBD.width - uA;
		var vA:Number = Math.floor(tileableBD.height * v);
		var vB:Number = tileableBD.height - vA;
		
		var uBvA:Rectangle = new Rectangle(uA, 0, uB, vA);
		var uAvB:Rectangle = new Rectangle(0, vA, uA, vB);
		var uAvA:Rectangle = new Rectangle(0, 0, uA, vA);
		var uBvB:Rectangle = new Rectangle(uA, vA, uB, vB);
		
		target.lock();
		//target.fillRect(target.rect, 0x000000);
		target.copyPixels(tileableBD, uBvA, new Point(0, vB), null, null, true);
		target.copyPixels(tileableBD, uAvB, new Point(uB, 0), null, null, true);
		target.copyPixels(tileableBD, uAvA, new Point(uB, vB), null, null, true);
		target.copyPixels(tileableBD, uBvB, new Point(0, 0), null, null, true);
		target.unlock();
	}
	
	public static function wrap(tileableBD:BitmapData, u:Number = 0, v:Number = 0):BitmapData {
		u = Maths.wrap(u, 1), 1;
		v = Maths.wrap(v, 1), 1;
		//trace("u: "+u+"v: "+v)
		var bmd:BitmapData = new BitmapData(tileableBD.width, tileableBD.height, true, 0x112233);
		
		var uA:Number = Math.floor(tileableBD.width * u);
		var uB:Number = tileableBD.width - uA;
		var vA:Number = Math.floor(tileableBD.height * v);
		var vB:Number = tileableBD.height - vA;
		
		var uBvA:Rectangle = new Rectangle(uA, 0, uB, vA);
		var uAvB:Rectangle = new Rectangle(0, vA, uA, vB);
		var uAvA:Rectangle = new Rectangle(0, 0, uA, vA);
		var uBvB:Rectangle = new Rectangle(uA, vA, uB, vB);
		
		bmd.copyPixels(tileableBD, uBvA, new Point(0, vB), null, null, true);
		bmd.copyPixels(tileableBD, uAvB, new Point(uB, 0), null, null, true);
		bmd.copyPixels(tileableBD, uAvA, new Point(uB, vB), null, null, true);
		bmd.copyPixels(tileableBD, uBvB, new Point(0, 0), null, null, true);
		//bmd.unlock();
		return bmd;
	}
}
}


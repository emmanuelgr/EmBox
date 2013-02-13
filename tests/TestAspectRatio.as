package {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;

import gr.emmanuel.emBoxAS3.core.AspectRatio;
import gr.emmanuel.emBoxAS3.utils.BitmapDatas;

/**
 * ...
 * @author emmanuel
 */

[SWF(width="600",height="1000",frameRate="25",backgroundColor="#222222")]

public class TestAspectRatio extends Sprite {
	private var cntrX:Number;
	private var accumilator:Number = 30;
	
	[Embed(source="uv1024x256.jpg")]
	private var PngBig:Class;
	[Embed(source="uv128x32.jpg")]
	private var PngSl:Class;
	
	[Embed(source="uv256x1024.jpg")]
	private var PngBigV:Class;
	[Embed(source="uv32x128.jpg")]
	private var PngSlV:Class;
	
	private var bitmap:Bitmap;
	private var size:int = 150;
	private var counter:int = 0;
	
	public function TestAspectRatio() {
		if (stage)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event = null):void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		stage.scaleMode = StageScaleMode.NO_SCALE;
		
		cntrX = stage.stageWidth / 2;
		var bmdBig:BitmapData = (new PngBig() as Bitmap).bitmapData;
		var bmdSml:BitmapData = (new PngSl() as Bitmap).bitmapData;
		var bmdBigV:BitmapData = (new PngBigV() as Bitmap).bitmapData;
		var bmdSmlV:BitmapData = (new PngSlV() as Bitmap).bitmapData;
		
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdBig, size, size, AspectRatio.MAINTAIN, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdSml, size, size, AspectRatio.MAINTAIN, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdBig, size, size, AspectRatio.CROP, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdSml, size, size, AspectRatio.CROP, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdBig, size, size, AspectRatio.FIT, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdSml, size, size, AspectRatio.FIT, false, 0xffffff, false));
		distribute(bitmap);
		
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdBigV, size, size, AspectRatio.MAINTAIN, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdSmlV, size, size, AspectRatio.MAINTAIN, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdBigV, size, size, AspectRatio.CROP, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdSmlV, size, size, AspectRatio.CROP, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdBigV, size, size, AspectRatio.FIT, false, 0xffffff, false));
		distribute(bitmap);
		
		bitmap = new Bitmap(BitmapDatas.resize(bmdSmlV, size, size, AspectRatio.FIT, false, 0xffffff, false));
		distribute(bitmap);
	
	}
	
	private function distribute(aDO:DisplayObject):void {
		addChild(aDO);
		aDO.y = accumilator;
		if (counter % 2) {
			aDO.x = cntrX  +10
			accumilator += size + 10;
		} else {
			aDO.x = cntrX - size
		}
		
		counter++;
	}

}
}


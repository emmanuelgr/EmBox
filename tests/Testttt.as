package {
import flash.display.Sprite;
import flash.text.TextField;
import flash.utils.ByteArray;
import flash.utils.setInterval;

[SWF(width="300",height="600",frameRate="25",backgroundColor="#222222")]

public class Testttt extends Sprite {
	public function Testttt() {
		
		var a:Object = 1;
		var b:Object = "1";
		if (a === b)			trace("1");
		if (a == b)			trace("2");
	 var t:TextField = new TextField();
	 var o:Object = { asd:1 };
	 delete o.asd;
	 trace( o.asd);
	 var x:XML = <sd>as</sd>;
	 try 
	 {
		 var oq:Object = this["dfg"]("df", "Dff");
		 
	 }catch (err:TypeError)
	 {
		 trace("1");
	 }catch (err:ArgumentError)
	 {
			 trace("2");
		 
	 }
	}

}
}
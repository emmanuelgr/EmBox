package emBox.commands{
	import emBox.commands.*;
	import emBox.commands.vfxs.*;
	import flash.display.*;
	import flash.events.*;

	public class CAppearAt extends CSerial {
		public var appears:ACommand;
		protected var papa:DisplayObjectContainer;
		protected var dispalyObj:DisplayObject;
    private var index:int;

		public function CAppearAt(
		dispalyObj:DisplayObject,
		papa: DisplayObjectContainer,
    index:int,
		appears:ACommand = null
		){
			super();
			this.dispalyObj = dispalyObj;
			this.papa = papa;
      this.index = index;
			appears!=null ?	 this.appears = appears:
			this.appears = new VFXFade(dispalyObj,  0, 1);
			init();
		}
		private function init():void {
			add( new CAddRemoveChildAt( papa, dispalyObj, index ) );
			add( appears );
		}
	}
}


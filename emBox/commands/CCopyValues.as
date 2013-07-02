package emBox.commands {
    import emBox.utils.Objects;
	/**
	 * ...
	 * @author emmanuel
	 */
	public class CCopyValues  extends ACommand {
		public var inObjTarget:Object;
		public var inObjSource:Object;
		public var inAttributes:Array;
		public var outObjTarget:Object;
		public var outObjSource:Object;
		public var outAttributes:Array;

		public function CCopyValues (
		inObjTarget:Object, inObjSource:Object, inAttributes:Array,
		outObjTarget:Object = null , outObjSource:Object= null, outAttributes:Array= null
		){
			this.inObjTarget = inObjTarget;
			this.inObjSource = inObjSource;
			this.inAttributes = inAttributes;
			this.outObjTarget = outObjTarget;
			this.outObjSource = outObjSource;
			this.outAttributes = outAttributes;
		}

		override protected function doIn():void  {
			super.doIn();
      Objects.copyValues( inObjTarget, inObjSource, inAttributes);
			executeInComplete();
		}

		override protected function doOut():void {
			super.doOut();
			Objects.copyValues( outObjTarget, outObjSource, outAttributes);
			executeOutComplete();
		}
	}
}


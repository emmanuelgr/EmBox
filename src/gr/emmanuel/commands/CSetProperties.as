package gr.emmanuel.commands {
    import gr.emmanuel.utils.Objects;
	/**
	 * ...
	 * @author emmanuel
	 */
	public class CSetProperties  extends ACommand {
		public var inObjTarget:Object;
		public var inObjSource:Object;
		public var outObjTarget:Object;
		public var outObjSource:Object;

		public function CSetProperties (
		inObjTarget:Object, inObjSource:Object,
		outObjTarget:Object = null , outObjSource:Object= null
		){
			this.inObjTarget = inObjTarget;
			this.outObjTarget = outObjTarget;
			this.inObjSource = inObjSource;
			this.outObjSource = outObjSource;
		}

		override protected function doIn():void  {
			super.doIn();
      Objects.setProperties( inObjTarget, inObjSource);
			executeInComplete();
		}

		override protected function doOut():void {
			super.doOut();
			Objects.setProperties( outObjTarget, outObjSource);
			executeOutComplete();
		}
	}
}

